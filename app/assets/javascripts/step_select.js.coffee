$ ->
  $("body").on 'change', "#family_city_id, #search_city_id_in", (event) ->
    select = $(event.target)
    nested = $(select.parent()).find('.nested_select').first()
    if $(select).val()
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
        else
          $(nested).html("")
    else
      $(nested).html("")
    # $(nested).html('<img src="/assets/loader.gif" />')
  # $("#family_city_id, #search_city_id_in").trigger 'change'
