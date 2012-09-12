$ ->
  $('#dev-list').modal(
    "backdrop" : "static",
    "keyboard" : true,
    'show' : false
    )
	
  $('#show-dev').click ->
    $('#dev-list').modal(show:true)
  
  
  ind = 0  
  dev = new Array();
  $('input[type="checkbox"]:checked + span').each ->
    dev[ind] = $(this).text()
    ind += 1
  
  #$('.select-dev-list').append("[ "+developers+" ]")