ActiveAdmin.register Category do
  include ActiveAdmin::AjaxFilter

  permit_params :id, :name
  config.sort_order = 'id_asc'
  config.per_page = 3
end