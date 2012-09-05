$ ->
  $('#dev-list').modal(
    "backdrop" : "static",
    "keyboard" : true,
    'show' : false
    )
	
  $('#show-dev').click ->
	  $('#dev-list').modal(show:true)
