ActiveAdmin.register Subcategory do
  include ActiveAdmin::AjaxFilter

  permit_params :id, :name, :category_id
  config.sort_order = 'id_asc'
  config.per_page = 3
end