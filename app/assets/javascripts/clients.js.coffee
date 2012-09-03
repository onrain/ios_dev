$ ->
  
  $('#new-company').modal(
      "backdrop" : "static",
      "keyboard" : true,
      'show' : false
      )
    
  $('#get-new-company').click ->
    $('#new-company').modal(show:true)
    
  $('#new-com').click ->
    document.location.reload(true)