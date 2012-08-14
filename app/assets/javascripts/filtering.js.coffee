$ ->
  $('.filter_value').on 'click', (event) ->
    $(event.target).toggle()
    $(event.target).parent().find(".primary_filter").toggle()
    $(event.target).parent().find(".primary_filter select").focus()


  $('.primary_filter select').on 'blur change', (event) ->
    # $(event.target).toggle()
    $('.fam_filter').submit()

  $('.delete_multiple_families').on 'click', (event) ->
    if $('input[type=checkbox][id^=model_ids_]:checked:enabled').length > 0
      checked = $('input[type=checkbox][id^=model_ids_]:checked:enabled').map (i, el) ->
        return $(el).attr('value')
      form = $('form#delete_multiple')
      for id in checked
        $(form).append('<input id="model_ids_" name="model_ids[]" type="hidden" value="'+ id + '">')

      $(form).submit()
