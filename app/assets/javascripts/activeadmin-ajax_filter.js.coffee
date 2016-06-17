$ ->
  apply_filter_ajax_select = () ->
    $('.filter_ajax_select select, .ajax_select select').each (_, select) ->
      select = $(select)
      valueField = select.data('value-field')
      searchFields = select.data('search-fields').split(' ')
      staticRansack = select.data('static-ransack')

      ajaxFields = select.data('ajax-search-fields')
      if ajaxFields
        ajaxFields = ajaxFields.split(' ')
      else
        ajaxFields = []

      ordering = select.data('ordering')
      url = select.data('url')

      loadOptions = (q, callback) ->
        $.ajax
          url: url
          type: 'GET'
          dataType: 'json'
          data:
            q: q
            limit: select.data('limit')
            order: ordering
          error: ->
            callback()
          success: (res) ->
            callback(res)

      relatedInput = (field) ->
        $("[name*=#{field}]", select.parents('form'))

      select.selectize
        valueField: valueField
        labelField: searchFields[0]
        searchField: searchFields
        sortField: ordering.split(',').map (clause)->
          c = clause.trim().split(' ')
          { field: c[0], direction: c[1] }
        options: []
        create: false
        render:
          option: (item, escape) ->
            html = searchFields.map (field, index)->
              value = escape(item[field])

              if index == 0
                klass = 'primary'
              else
                klass = 'secondary'

              "<span class='#{klass}'>#{value}</span>"

            "<div class='item'>#{html.join('')}</div>"

        load: (query, callback) ->
          if query.length
            q = {}
            q[select.data('ransack')] = query

            ajaxFields.forEach (field) ->
              q["#{field}_eq"] = relatedInput(field).val()
              # clear cache because it wrong with changing values of ajaxFields
              select.loadedSearches = {}

            for ransack, value of staticRansack
              q[ransack] = value

            loadOptions(q, callback)
          else
            callback()

        onInitialize: ->
          selectize = this
          selectedValue = select.data('selected-value')
          selectedRansack = "#{valueField}_eq"

          if selectedValue
            q = {}
            q[selectedRansack] = selectedValue

            loadOptions(q, (res)->
              if res.length
                selectize.addOption(res[0])
                selectize.addItem(res[0][valueField])
            )

          ajaxFields.forEach (field) ->
            relatedInput(field).change ->
              selectize.clearOptions()

  # apply ajax filter to all static inputs
  apply_filter_ajax_select()

  # apply ajax filter on inputs inside has_many entries
  $("form.formtastic .has_many_add").click ->
    setTimeout((-> apply_filter_ajax_select()), 0)