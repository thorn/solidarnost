$ ->
  $('.filter_value').on 'click', (event) ->
    $(event.target).toggle()
    $(event.target).parent().find(".primary_filter").toggle()
    $(event.target).parent().find(".primary_filter select").focus()


  $('.primary_filter select').on 'blur', (event) ->
    $(event.target).toggle()
    $('.fam_filter').submit()
