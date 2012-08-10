$ ->
  $("body").on 'change', "#family_city_id", (event) ->
    select = $(event.target)
    nested = $(select.parent()).find('.nested_select').first()
    $.get "/admin/cities/get_new.json?id=#{$(select).val()}", (data) ->
      unless data.last is true
        # select.removeAttr('id')
        # select.removeAttr('name')
        res = '<select name="family[city_id]" id="family_city_id">'
        for city in data.cities
          res += "<option value=#{city.id}>#{city.name}</option>"
        res += "</select>"
        res += '<div class="nested_select"></div>'

        $(nested).html(res)
