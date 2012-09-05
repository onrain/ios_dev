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
        $('#form-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Title '+errors.name+'</span>')
      $('#error-append').mousemove ->
        $(this).remove()
        $('.icon-remove').remove()
    
    $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      $('#client_company_id').append('<option value'+data.id+'>'+data.name+'</option>')
      $('#form-notice').empty()
      $('#form-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Company was success create!</span>')
      $('#success-append').mouseover ->
        $(this).remove()
        $('.icon-ok').remove()
      
      
