require 'active_admin'
require 'active_admin/ajax_filter/engine'
require 'active_admin/ajax_filter/version'
require 'active_admin/inputs/filters/ajax_select_input.rb'

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

            render json: scope.order(:created_at).limit(params[:limit] || 10)
          end
        end
      end
    end
  end
end
