module ActiveAdmin
  module Inputs
    module Filters
      class AjaxSelectInput < SelectInput
        include ActiveAdmin::Inputs::AjaxCore
      end
    end
  end
end