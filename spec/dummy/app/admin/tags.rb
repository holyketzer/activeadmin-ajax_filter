ActiveAdmin.register Tag do
  permit_params :id, :name, :subcategory_id
  config.sort_order = 'id_asc'

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs do
      f.input :name
      f.input :subcategory, as: :ajax_select, data: {
        search_fields: ['category.name'],
        ordering: 'name ASC',
        url: '/admin/subcategories/filter',
        limit: Subcategory::AJAX_LIMIT
      }
    end

    f.actions
  end
end
