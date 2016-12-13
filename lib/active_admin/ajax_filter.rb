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
            scope = collection.ransack(params[:q]).result
            scope = scope.order(params[:order]).limit(params[:limit] || 10)
            scope = apply_collection_decorator(scope)

            render plain: scope.to_json
          end
        end
      end
    end
  end
end
