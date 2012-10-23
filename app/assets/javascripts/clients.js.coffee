$ ->
    
  
  $('#new-company').modal(
      "backdrop" : "static",
      "keyboard" : true,
      'show' : false
      )
 
 
  verify.init('confirm')
 
  $('#get-new-company').click ->
    $('#new-company').modal(show:true)
    $('#cname').val('')
    $('#cwebsite').val('')
    $('.form-notice').empty()

  if (/new/).test(window.location.pathname)
    if $('#client_company_id').children().length > 1
      $('#client_company_id').children().eq(1).attr('selected','selected')
  
  
  
  $('#new-com').click ->
     $('.form-notice').empty()
     
     $('#new-company form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
      $('.form-notice').empty()
      errors = $.parseJSON(data.responseText)
      $('.form-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Title '+errors.name+'</span>')
      $('.form-notice').mousemove ->
        $(this).empty()
    
    $('#new-company form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      $('.form-notice').empty()
      $('#client_company_id').append('<option value='+data.id+' selected="selected">'+data.name+'</option>')
      
      $('.form-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Company was success create!</span>')
      $('.form-notice').mousemove ->
        $(this).empty()
  


  $('#client_name').bind 'input': ->

    company = $('#client_company_id :selected').text().toLowerCase().replace(/\s+/g,'')

    name = $(this).val().toLowerCase()


        
    res = name.split(" ")
    getHandleName(res)
    
    
    $('div[id*="handle"]').mousemove ->
      $(this).css('cursor':'pointer', 'text-decoration':'underline')
    $('div[id*="handle"]').mouseleave ->
      $(this).css('text-decoration':'none')
      
      
      
      
    $('div[id*="handle"]').click ->
      
      company = $('#client_company_id option:selected').text().toLowerCase().replace(/\s+/g,'')
      company_val = $('#client_company_id option:selected').val()
      if company_val is ''
        company = ''
        
      $('#client_handle').val(company+'/'+$(this).text().replace(/\s+/g,''))
      
      $('#client_company_id option').click ->
        company = $('#client_company_id option:selected').text().toLowerCase().replace(/\s+/g,'')
        company_val = $('#client_company_id option:selected').val()
        if company_val is ''
          company = ''
        
        handle_val = $('#client_handle').val()
        pos_slesh = handle_val.indexOf('/')

        handle_name = handle_val.substring(pos_slesh+1, handle_val.length)

        $('#client_handle').val(company+'/'+handle_name)
        
  $('.btn-delete-client').live 'click': ->

    id = $(this).attr('id')
  
    $.get '/admin/clients?type=relations&id='+id, (data) =>
      count = Object.keys(data).length
      if count > 0
        i = 0;j = 0
        proj_len = data['project'][0].length
        app_len = data['application'][0].length if typeof(data['application']) isnt 'undefined'
        text = "<span style='font-size:18px;'>With this client will be deleted:</span><br />"
        text += "<span style='font-size:15px;'>Projects:</span>"
        while j<proj_len
          text += data['project'][0][j].name
          if j+1 isnt proj_len
            text+= ", "
          else text +="<br />"
          j++
        if typeof(data['application']) isnt 'undefined'  
          text += "<span style='font-size:15px;'>Applications:</span>"
          
          while i<app_len
            text += data['application'][0][i].product_name
            if i+1 isnt app_len
              text+= ", "
            else text +="\n"
            i++
        verify.run('confirm',text)
        $('#yes_btn').click ->
          $('#no_btn').removeClass('close')
          $('.confirm-content').text("Do you want to delete application folder?")
          $('#yes_btn').click ->
            $.get '/admin/clients?method=delete&client_id='+id, (data) =>
              $.post "/admin/clients/" + id, {_method:'delete'}, (data) =>
                location.reload(true)

          $('#no_btn').click ->
            $.get '/admin/clients?method=move&client_id='+id, (data) =>
              $.post "/admin/clients/" + id, {_method:'delete'}, (data) =>
                location.reload(true)
      else
        verify.run('confirm','Are you sure?')
        $('#yes_btn').click ->
          $.post "/admin/clients/" + id, {_method:'delete'}, (data) =>
            location.reload(true)

    return false

   

