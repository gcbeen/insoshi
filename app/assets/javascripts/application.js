// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.ui.all
//= require jquery.ui.datepicker-zh-CN
//= require jquery-ui-timepicker-addon
//= require jquery-ui-timepicker-zh-CN
//= require bootstrap
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require bootstrap-wysihtml5
//= require inputs-ext/wysihtml5
//= require bootstrap-wysihtml5/locales/zh-CN
//= require social-share-button
//= require jquery-hotkeys
//= require zeroclipboard
//= require_tree .
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

// Autocomplete
var availableTags = ["ActionScript", "AppleScript", "Asp", "BASIC", "C", "C++", "Clojure", "COBOL", "ColdFusion", "Erlang", "Fortran", "Groovy", "Haskell", "Java", "JavaScript", "Lisp", "Perl", "PHP", "Python", "Ruby", "Scala", "Scheme"];
 
$("#tags").autocomplete({
	source: availableTags
});
$('.typeahead').typeahead({source: availableTags});
$('#spinner').spinner();
$('button').button();
$('.button').button();
$('#datepicker').datepicker({inline: true});

function reply(nickname, floor_num, url) {
  var editor = $('#comment_body').data('wysihtml5').editor;
  var html_str = "<a href='#reply-" + floor_num + "'>#" + floor_num + "楼</a> <a href='" + url + "'>@" + nickname + "</a>"
  editor.focus();
  editor.composer.commands.exec('insertHTML', "\r\n");
  editor.composer.commands.exec('insertHTML', html_str);
}

function edit_reply(reply_floor, path) {
  var reply_body = $('#' + reply_floor + " .body").html();
  var editor = $('#comment_body').data('wysihtml5').editor;
  editor.focus();
  editor.composer.commands.exec('insertHTML', reply_body);
  $('#new_comment').attr('action', path);
}
