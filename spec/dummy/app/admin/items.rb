ActiveAdmin.register Item do
  permit_params :id, :name, :subcategory_id, tag_ids: []
  config.sort_order = 'id_asc'

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    f.inputs do
      f.input :name

      f.input :subcategory, as: :ajax_select, data: {
        search_fields: [:name],
        url: '/admin/subcategories/filter',
        limit: Subcategory::AJAX_LIMIT
      }

      f.input :tags, as: :ajax_select, data: {
        search_fields: ['name'],
        url: '/admin/tags/filter'
      }
    end


    f.actions
  end
end
