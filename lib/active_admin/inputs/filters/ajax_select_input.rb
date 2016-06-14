module ActiveAdmin
  module Inputs
    module Filters
      class AjaxSelectInput < SelectInput
        include ActiveAdmin::Inputs::AjaxCore

        def collection_from_association
          super.limit(collection_limit)
        end
      end
    end
  end
end