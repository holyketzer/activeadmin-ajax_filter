require 'rails/engine'

module ActiveAdmin
  module AjaxFilter
    # Including an Engine tells Rails that this gem contains assets
    class Engine < ::Rails::Engine
      require 'selectize-rails'
    end
  end
end