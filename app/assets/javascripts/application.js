// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.tablesorter
//= require twitter/bootstrap
//= require bootstrap/bootstrap-tabs
//= require bootstrap/bootstrap-buttons
//= require bootstrap/bootstrap-twipsy
//= require bootstrap/bootstrap-popover
//= require bootstrap/bootstrap-dropdown
//= require chosen.jquery.min
//= require filtering
//= require step_select
//= require_tree .
//= require_self

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parents(".fields").first().hide();
}
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
}
$(function(){

  $(".tabs").tabs()
  $('.accordion').accordion();
  $('.select_multiple').chosen({allow_single_deselect:true});
  $("a[rel=twipsy]").twipsy({placement: "right"});
  $(".dropdown").dropdown();
  $(".sortable_table").tablesorter({headers: {0: { sorter: false} } });
  // $(".sortable_family_table").tablesorter({headers: {0: { sorter: false}, 1: {sorter: false}, 2: {sorter: false}, 3: {sorter: false}, 4: {sorter: false}, 5: {sorter: false}, 6: {sorter: false}, 7: {sorter: false} } });

  jQuery("a.scroll_to").click(function () {
      elementClick = jQuery(this).attr("href")
      destination = jQuery(elementClick).offset().top;
      jQuery("html:not(:animated),body:not(:animated)").animate({scrollTop: destination}, 1100);
      return false;
  });

  $("a[href='#']").click(function(e){ e.preventDefault();});
  $("a[rel=popover]").popover({
    offset: 10,
    html: true
  });

  $("#mark_all").click(function(ev){
    if ($(this).attr("checked")){
      $("input[name^='model_ids']").attr("checked", true);
    } else {
      $("input[name^='model_ids']").attr("checked", false);
    }
  });
  $("#delete_marked a").click(function(ev){
    var confirm_text = $("#delete_marked a").attr("data-confirm");
    if(confirm_text){
      if (!confirm(confirm_text)){
        return false;
      }
    }
    $("#delete_multiple").submit();
    return false;
  })
  $("#delete_multiple, #read_multiple").keypress(function (ev) {
    if(ev.keyCode === 13){
      return false;
    }
  });

  $("#read_marked a").click(function(ev){
    var confirm_text = $("#read_marked a").attr("data-confirm");
    if(confirm_text){
      if (!confirm(confirm_text)){
        return false;
      }
    }
    $("#read_multiple").submit();
    return false;
  });

  $('.family-search-button').click(function () {
    if($("#search_title_cont").val() != ""){
      $("#family_search").submit();
    }
    return false;
  });

  $('.clear_form_button').click(function () {
    $(this.form).find('input[type=text],input[type=number]').each(function (index, input) {
      $(input).val("")
    });
    $(this.form).find('input[type=checkbox]').each(function (index, input){
      $(input).attr("checked", false);
    });
    $(this.form).find('select').each(function (index, select) {
      $(select.options).each(function (index, option) {
        option.selected = false;
      });
      select.options[0].selected = true;
    });
  });

  $('.date_select').datepicker({ dateFormat: "yy-mm-dd" });
  $('.print').on('click', function(){window.print(); return false;});

  $('.make_visit').on('click', function(el){
    $("#family_make_visit").val("true")
  });
  $('.excel_export').on('click', function(el){
    search_field_name = ".family_search"
    form = $(search_field_name).last()
    action = $(form).attr('action')
    $(form).attr('action', action + ".xls");
    $(form).submit();
    $(form).attr('action', action);
  });

  $('.goto_id').on('submit', function(ev){
    id = $(ev.target).find('input[type=text]').val();
    if ((id != null) && (id.match(/\d/) > 0)){
      window.location.assign('/families/' + id);
    }
  });

  $('body').on('click', '.pagination a', function(ev){
    var page = $(ev.target).attr('href').match(/page=(\d*)/)[1];
    if ($(".family_search").length > 0) {
      $(".family_search input#page").val(page)
      $(".family_search").submit();
      return false;
    }
  });
});
