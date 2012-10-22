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

String.prototype.ucfirst = function(){return this.charAt(0).toUpperCase() + this.substr(1);}
getChildren = function(selector){return $(selector).html();}


$(function(){trim = function (str, chars) {return ltrim(rtrim(str, chars), chars);};ltrim = function(str, chars) {chars = chars || "\\s";return str.replace(new RegExp("^[" + chars + "]+", "g"), "");};rtrim = function (str, chars) {chars = chars || "\\s";return str.replace(new RegExp("[" + chars + "]+$", "g"), "");};$td = function(params, attr){var td;if(typeof(params) == 'object'){params = params.join(' ');};td = typeof(attr) == 'string'? "<td "+attr+">":"<td>";td +=params+"</td>";return td;};$th = function(params, attr){var th;if(typeof(params) == 'object'){params = params.join(' ');}th = typeof(attr) == 'string'? "<th "+attr+">":"<th>";th +=params+"</th>";return th;};$tr = function(params, attr){var tr;if(typeof(params) == 'object'){  params = params.join(' ');}tr = typeof(attr) == 'string'? "<tr "+attr+">":"<tr>";tr +=params+"</tr>";return tr;};$div = function(params, attr){var div;if(typeof(params) == 'object'){params = params.join(' ');};div = typeof(attr) == 'string'? "<div "+attr+">":"<div>";div +=params+"</div>";return div;};$link_to = function(params, path, attr){ var a;a = typeof(path) == 'string'? "<a href="+path:"<a";a += typeof(attr) == 'string'? " "+attr+">":">";a +=params+"</a>";return a;};$table = function(params, attr){var table;if(typeof(params) == 'object'){  params = params.join(' ');}table = typeof(attr) == 'string'? "<table "+attr+">":"<table>";table +=params+"</table>";return table;}});
$.fn.debug = function(e){ alert(e); }
function getHandleName(res)
{
    var count, i, j, k, variant;
    j = 1;    
    i = 0;    
    variant = 4;    
    count = 0;
    $('.proj-h-variants').empty()
    while (count < variant) {
      $('.proj-h-variants').append("<div class='variant" + count + "'></div>");
      count++;
    }
    
    while (i < res.length) {
      k = 0;
      $('.variant0').append('<div id="handle' + i + '"></div>');
      $('.variant1').append('<div id="handle' + i + '"></div>');
      $('.variant2').append('<div id="handle' + i + '"></div>');
      $('.variant3').append('<div id="handle' + i + '"></div>');
      while (k < j) {
        $('.variant0 #handle' + i).append(res[k]);
        $('.app').remove();
        $('.variant0 #handle' + i).mousemove(function() {
          $('.app').remove();
          return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
        });
        if (k + 1 < j) {
          $('.variant1 #handle' + i).append(res[k] + ".");
          $('.app').remove();
          $('.variant1 #handle' + i).mousemove(function() {
            $('.app').remove();
            return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
          });
        } else if (k > 0) {
          $('.variant1 #handle' + i).append(res[k]);
        }
        if (k + 1 < j) {
          $('.variant2 #handle' + i).append(res[k] + "-");
          $('.app').remove();
          $('.variant2 #handle' + i).mousemove(function() {
            $('.app').remove();
            return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
          });
        } else if (k > 0) {
          $('.variant2 #handle' + i).append(res[k]);
        }
        if (k + 1 < j) {
          $('.variant3 #handle' + i).append(res[k] + "_");
          $('.app').remove();
          $('.variant3 #handle' + i).mousemove(function() {
            $('.app').remove();
            return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
          });
        } else if (k > 0) {
          $('.variant3 #handle' + i).append(res[k]);
        }
        k++;
      }
      j++;
      i++;
    }
}


function getRelativePath(res, application_class, place)
{
  var count, i, j, k, variant;

    j = 1;
    i = 0;    
    variant = 4;    
    count = 0;
    
    while (count < variant) {
      place.find('.relative-variant').append("<div class='variant" + count + "'></div>");
      count++;
    }
    
    while (i < res.length) {
      k = 0;
      place.find('.variant0').append('<div id="relative' + i + '" class="' + application_class + '"></div>');
      place.find('.variant1').append('<div id="relative' + i + '" class="' + application_class + '"></div>');
      place.find('.variant2').append('<div id="relative' + i + '" class="' + application_class + '"></div>');
      place.find('.variant3').append('<div id="relative' + i + '" class="' + application_class + '"></div>');
      while (k < j) {
        place.find('.variant0 #relative' + i).append(res[k]);
        $('.app').remove();
        place.find('.variant0 #relative' + i).mousemove(function() {
          $('.app').remove();
          return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
        });
        if (k + 1 < j) {
          place.find('.variant1 #relative' + i).append(res[k] + ".");
          $('.app').remove();
          place.find('.variant1 #relative' + i).mousemove(function() {
            place.find('.app').remove();
            return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
          });
        } else if (k > 0) {
          place.find('.variant1 #relative' + i).append(res[k]);
        }
        if (k + 1 < j) {
          place.find('.variant2 #relative' + i).append(res[k] + "-");
          $('.app').remove();
          place.find('.variant2 #relative' + i).mousemove(function() {
            $('.app').remove();
            return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
          });
        } else if (k > 0) {
          place.find('.variant2 #relative' + i).append(res[k]);
        }
        if (k + 1 < j) {
          place.find('.variant3 #relative' + i).append(res[k] + "_");
          $('.app').remove();
          place.find('.variant3 #relative' + i).mousemove(function() {
            $('.app').remove();
            return $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>");
          });
        } else if (k > 0) {
          place.find('.variant3 #relative' + i).append(res[k]);
        }
        k++;
      }
      j++;
      i++;
    }
}


var confirm = {};
confirm.init = function(id){
  $('#confirm').modal({
    'show' : false,
    'keyboard' : false,
    'backdrop':false
  });
}


confirm.run = function(id,text) {
    $('#'+id).modal({'show':true});
    $('.confirm-content').empty();
    $('.confirm-content').html(text);
}

confirm.click = function(id){
    var result = $('#'+id).click(function(){
      return true;
    });
    if(result)
    {
      return true;
    } else return false;
    
    
    
}