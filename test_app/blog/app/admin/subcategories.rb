ActiveAdmin.register Subcategory do
  include ActiveAdmin::AjaxFilter
  decorate_with SubcategoryDecorator.name

  permit_params :id, :name, :category_id
  config.sort_order = 'id_asc'
  config.per_page = 3

  show do |subcategory|
    panel 'Async panel', class: 'async-panel', 'data-url' => panel_admin_subcategory_path(subcategory)
  end

  member_action :panel do
    @data = 'Loaded async'

    render layout: false
  end
end
