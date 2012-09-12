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
//= require_tree .


$.fn.simpleContentSearch=function(a){function d(a){$("."+b.searchList).each(function(){$(this).children(b.searchItem).each(function(){var c=$(this);if(!c.html().match(new RegExp(".*?"+a+".*?","i"))){if(b.effect=="fade"){$(this).parent("."+b.searchList).fadeOut()}else{$(this).parent("."+b.searchList).hide()}}else{if(b.effect=="fade"){$(this).parent("."+b.searchList).fadeIn()}else{$(this).parent("."+b.searchList).show()}return false}return})})}var b={active:"active",normal:"normal",searchList:"searchable tr",searchItem:"td",effect:"none"};var c=this;var a=$.extend(b,a);return this.each(function(){c.blur(function(){var b=c;b.removeClass().addClass(a.normal)});c.focus(function(){var b=c;b.removeClass().addClass(a.active)});c.keyup(function(){d(c.val())});return this})}


$(function(){
    $('.searchFilter').simpleContentSearch({
        'active' : 'searchBoxActive',
        'normal' : 'searchBoxNormal',
        'searchList' : 'searchable p',
        'searchItem' : 'span'
    });
});

/*
client = new Object();
client.click = 0
client.count = function(el){

	    var click = this.click++;
	    el.attr('id', click);
	    
	    if(parseInt(el.attr('id')) > 1)
	    {
			  $('.add-or-get-h').popover('hide')
			  $('.add-or-get-h').attr('id','0')
		  }
	}
	
	



onclick
client.count($(this))

id for all el is 0 default


*/