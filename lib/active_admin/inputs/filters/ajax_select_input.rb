module ActiveAdmin
  module Inputs
    module Filters
      class AjaxSelectInput < SelectInput
        DEFAULT_LIMIT = 5

        def pluck_column
          klass.reorder("#{method} asc").limit(collection_limit).uniq.pluck(method)
        end

        def collection_from_association
          super.limit(collection_limit)
        end

        def input_html_options
          super.merge(
            'data-limit' => collection_limit,
            'data-value-field' => value_field,
            'data-search-fields' => search_fields,
            'data-ordering' => ordering,
            'data-ransack' => ransack,
            'data-selected-value' => selected_value,
            'data-url' => url,
          )
        end

        def ajax_data
          options[:data] || {}
        end

        def collection_limit
          ajax_data[:limit] || DEFAULT_LIMIT
        end

        def value_field
          ajax_data[:value_field] || :id
        end

        def search_fields
          ajax_data[:search_fields] || raise(ArgumentError, 'search_fields in required')
        end

        def ordering
          ajax_data[:ordering] || "#{search_fields.first} ASC"
        end

        def ransack
          ajax_data[:ransack] || "#{search_fields.join('_or_')}_cont"
        end

        def url
          ajax_data[:url] || "#{method.to_s.pluralize}/filter"
        end

        def selected_value
          if @object
            @object.try(:send, input_name)
          end
        end
      end
    end
  end
end