module ActiveAdmin
  module Inputs
    class AjaxSelectInput < ::Formtastic::Inputs::SelectInput
      include ActiveAdmin::Inputs::AjaxCore
    end
  end
end