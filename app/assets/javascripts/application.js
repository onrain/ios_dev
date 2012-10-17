//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap


$(function(){
path = window.location.pathname;

if ((/clients/).test(path))  $('#clients-nav').addClass('active');
if ((/admin\/companies/).test(path)) $('#company-nav').addClass('active');
if ((/admin\/managers/).test(path)) $('#manager-nav').addClass('active');
if ((/admin\/developers/).test(path)) $('#developers-nav').addClass('active');
if ((/admin\/projects/).test(path)) $('#projects-nav').addClass('active');
if ((/admin\/applications/).test(path)) $('#app-nav').addClass('active');

var amp, fullpath, isa, sort, type;

$('.sort').css({'color': 'black'});
$('.sort').mousemove(function() {return $(this).css({'text-decoration': 'none'});});

fullpath = document.location.href;
index_is = fullpath.indexOf('=');
amp = fullpath.indexOf('&');
type = fullpath.substring(index_is + 1, amp);
sort = fullpath.lastIndexOf('=');
sort = fullpath.substring(sort + 1, fullpath.length);

switch (type) {
  case 'asc':
    $('#' + sort).addClass('icon-chevron-up');
    $('#' + sort).parent().addClass('select-th');
    break;
  case 'desc':
    $('#' + sort).addClass('icon-chevron-down');
    $('#' + sort).parent().addClass('select-th');
}});


getChildren = function(selector){return $(selector).html();}


$(function(){trim = function (str, chars) {return ltrim(rtrim(str, chars), chars);};ltrim = function(str, chars) {chars = chars || "\\s";return str.replace(new RegExp("^[" + chars + "]+", "g"), "");};rtrim = function (str, chars) {chars = chars || "\\s";return str.replace(new RegExp("[" + chars + "]+$", "g"), "");};$td = function(params, attr){var td;if(typeof(params) == 'object'){params = params.join(' ');};td = typeof(attr) == 'string'? "<td "+attr+">":"<td>";td +=params+"</td>";return td;};$th = function(params, attr){var th;if(typeof(params) == 'object'){params = params.join(' ');}th = typeof(attr) == 'string'? "<th "+attr+">":"<th>";th +=params+"</th>";return th;};$tr = function(params, attr){var tr;if(typeof(params) == 'object'){  params = params.join(' ');}tr = typeof(attr) == 'string'? "<tr "+attr+">":"<tr>";tr +=params+"</tr>";return tr;};$div = function(params, attr){var div;if(typeof(params) == 'object'){params = params.join(' ');};div = typeof(attr) == 'string'? "<div "+attr+">":"<div>";div +=params+"</div>";return div;};$link_to = function(params, path, attr){ var a;a = typeof(path) == 'string'? "<a href="+path:"<a";a += typeof(attr) == 'string'? " "+attr+">":">";a +=params+"</a>";return a;};$table = function(params, attr){var table;if(typeof(params) == 'object'){  params = params.join(' ');}table = typeof(attr) == 'string'? "<table "+attr+">":"<table>";table +=params+"</table>";return table;}

});

