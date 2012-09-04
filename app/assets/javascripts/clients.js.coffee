$ ->


  $('#new-company').modal(
      "backdrop" : "static",
      "keyboard" : true,
      'show' : false
      )
    
  $('#get-new-company').click ->
    $('#new-company').modal(show:true)
    $('#cname').val('')
    $('#cwebsite').val('')
    $('#form-notice').empty()
    
  $('#new-com').click ->
          
     $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
      errors = $.parseJSON(data.responseText);
      if status is 'error'
        $('#form-notice').empty()
        $('#form-notice').append('<div style="color:red;">Title '+errors.name+'</div>')
        
    $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      $('#client_company_id').append('<option value'+data.id+'>'+data.name+'</option>')
      $('#form-notice').empty()
      $('#form-notice').append('<div style="color:red;">Company was success create!</div>')
      setInterval( ->
        $('#form-notice').animate('opacity':0)
      ,2000)
      
