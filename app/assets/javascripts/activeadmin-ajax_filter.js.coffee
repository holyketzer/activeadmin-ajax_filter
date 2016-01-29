$ ->
  $('.filter_ajax_select select').each (_, select) ->
    select = $(select)
    valueField = select.data('value-field')
    searchFields = select.data('search-fields').split(' ')

    loadOptions = (q, callback) ->
      $.ajax
        url: 'users/filter'
        type: 'GET'
        dataType: 'json'
        data:
          q: q
          limit: select.data('limit')
        error: ->
          callback()
        success: (res) ->
          callback(res)

    select.selectize
      valueField: valueField
      labelField: searchFields[0]
      searchField: searchFields
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