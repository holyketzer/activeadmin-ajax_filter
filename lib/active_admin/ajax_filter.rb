require 'active_admin'
require 'active_admin/ajax_filter/engine'
require 'active_admin/ajax_filter/version'
require 'active_admin/inputs/ajax_core'
require 'active_admin/inputs/ajax_select_input'
require 'active_admin/inputs/filters/ajax_select_input'

module ActiveAdmin
  module AjaxFilter
    class << self
      # @param [ActiveAdmin::DSL] dsl
      # @return [void]
      #
      def included(dsl)
        dsl.instance_eval do
          collection_action :filter, method: :get do
            scope = find_collection(except: [:pagination, :collection_decorator])
              .order(params[:order])
              .limit(params[:limit] || 10)
              .distinct

            search_fields = Array(params[:searchFields])

            related_table_search_fields = search_fields
              .select { |f| f.include?('.') }
              .map { |f| f.split('.') }

            related_table_search_fields.each do |related_table, _|
              scope = scope.preload(related_table)
            end

            res = apply_collection_decorator(scope).map do |item|
              item_json = item.as_json

              related_table_search_fields.each do |related_table, search_field|
                item_json[related_table + '.' + search_field] = item.send(related_table).send(search_field)
              end

              item_json
            end

            render plain: res.to_json
          end
        end
      end
    end
  end
end
