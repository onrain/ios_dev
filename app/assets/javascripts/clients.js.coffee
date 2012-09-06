$ ->


  $('#new-company').modal(
      "backdrop" : "static",
      "keyboard" : true,
      'show' : false
      )
  
  $('#handle-name').modal(
      "backdrop" : "static",
      "keyboard" : true,
      'show' : false
      )
  
  $('#get-handles').click ->
    $('#handle-name').modal(show:true)
    
    
  $('#get-new-company').click ->
    $('#new-company').modal(show:true)
    $('#cname').val('')
    $('#cwebsite').val('')
    $('.form-notice').empty()
    
  $('#new-com').click ->
     $('.form-notice').empty()    
     $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
      errors = $.parseJSON(data.responseText)
      if status is 'error'
        $('.form-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Title '+errors.name+'</span>')
      $('#error-append').mousemove ->
        $(this).remove()
        $('.icon-remove').remove()
    
    $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      $('#client_company_id').append('<option value'+data.id+'>'+data.name+'</option>')
      
      $('.form-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Company was success create!</span>')
      $('#success-append').mouseover ->
        $(this).remove()
        $('.icon-ok').remove()
      
      
      
  $('#new-handle').click ->
    $('.handle-notice').empty()
     
    $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
      $('.handle-notice').empty()
      errors = $.parseJSON(data.responseText)
      if status is 'error'
        $('.handle-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Handle name '+errors.handle_name+'</span>')
      $('#error-append').mousemove ->
        $(this).remove()
        $('.icon-remove').remove()
        
        
    $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      $('.handle-notice').empty()
      $('.app').remove()
      count = Object.keys(data).length
      i=0
      while i<count
        $('#table-show-handle').append("<tr class='app'><td>"+data[i].handle_name+"</td></tr>")
        i+=1
      $('.handle-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Handle was success create!</span>')
      $('#success-append').mouseover ->
        $(this).remove()
        $('.icon-ok').remove()
    