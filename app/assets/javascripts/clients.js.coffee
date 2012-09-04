$ ->
  
  $('#new-company').modal(
      "backdrop" : "static",
      "keyboard" : true,
      'show' : false
      )
    
  $('#get-new-company').click ->
    $('#new-company').modal(show:true)
    
  $('#new-com').click ->
    p =
      host:window.location.hostname,
      port:window.location.port
    
    $.get 'companies.json', (data) =>
      $('#client_company_id').append('<option value'+data.id+'>'+data.name+'</option>')
      $('#form-notice').empty()
      $('#form-notice').append('<div style="color:red;">Company was success create!</div>')
      
 
