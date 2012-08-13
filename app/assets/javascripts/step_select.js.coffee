$ ->
  $("body").on 'change', "#family_city_id, #search_city_id_in", (event) ->
    select = $(event.target)
    nested = $(select.parent()).find('.nested_select').first()
<<<<<<< HEAD
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
=======
    $.get("/admin/cities/get_new.json?id=#{$(select).val()}", (data) ->
      unless data.last is true
        res = '<select name="family[city_id]" id="family_city_id"><option></option>'
        for city in data.cities
          res += "<option value=#{city.id}>#{city.name}</option>"
        res += "</select>"
        res += '<div class="nested_select"></div>'

        $(nested).html(res))
      .error (data) ->
        $(nested).html("")


  $("body").on 'change', "#search_city_id_in", (event) ->
    select = $(event.target)
    nested = $(select.parent()).find('.nested_select').first()
    $.get("/admin/cities/get_new.json?id=#{$(select).val()}", (data) ->
      unless data.last is true
        res = '<select name="search[city_id_in]" id="search_city_id_in"><option></option>'
        for city in data.cities
          res += "<option value=#{city.id}>#{city.name}</option>"
        res += "</select>"
        res += '<div class="nested_select"></div>'

        $(nested).html(res))
      .error (data) ->
        $(nested).html("")

  $("body").on 'submit', "form[id^=edit_family], form#family_search, form#new_family", (event) ->
    if $('select[id^=family_city_id]').last().val() == ""
      $('select[id^=family_city_id]').last().removeAttr('name')
      $('select[id^=family_city_id]').last().removeAttr('id')

    if $('select[id^=search_city_id_in]').last().val() == ""
      $('select[id^=search_city_id_in]').last().removeAttr('name')
      $('select[id^=search_city_id_in]').last().removeAttr('id')
>>>>>>> a36e137e0639d70159577dd572a8910495d08d2d
