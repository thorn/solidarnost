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
//= require my_best_in_place
//= require my_jquery.purr
//= require twitter/bootstrap
//= require bootstrap/bootstrap-tabs
//= require bootstrap/bootstrap-buttons
//= require bootstrap/bootstrap-twipsy
//= require bootstrap/bootstrap-popover
//= require bootstrap/bootstrap-dropdown
//= require chosen.jquery.min
//= require search
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
  $('.select_multiple').chosen();
  $("a[rel=twipsy]").twipsy({placement: "right"});
  $(".dropdown").dropdown();
  $(".sortable_table").tablesorter({headers: {0: { sorter: false} } });
  $(".best_in_place").best_in_place();

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
  $("#delete_multiple").keypress(function (ev) {
    if(ev.keyCode === 13){
      return false;
    }
  });

  $('.family-search-button').click(function () {
    if($("#q_title_cont").val() != ""){
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

  $('.date_select').datepicker();
  $('.print').on('click', function(){window.print(); return false;});
});
