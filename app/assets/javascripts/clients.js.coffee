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
    $('.form-notice').empty()

  
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
    $('.handle-variant').empty()
    company = $('#client_company_id :selected').text().toLowerCase().replace(/\s+/g,'')

    name = $(this).val().toLowerCase()

    
        
    res = name.split(" ")
    j = 1
    i = 0
    variant = 4
    count = 0
    while count < variant
      $('.handle-variant').append("<div class='variant"+count+"'></div>")
      count++
    while i < res.length
      k = 0
      $('.variant0').append('<div id="handle'+i+'"></div>')
      $('.variant1').append('<div id="handle'+i+'"></div>')
      $('.variant2').append('<div id="handle'+i+'"></div>')
      $('.variant3').append('<div id="handle'+i+'"></div>')
      while k < j

        $('.variant0 #handle'+i).append(res[k])
        $('.app').remove()
        $('.variant0 #handle'+i).mousemove ->
          $('.app').remove()
          $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")         
        if k+1 < j
          $('.variant1 #handle'+i).append(res[k]+".")      
          $('.app').remove()
          $('.variant1 #handle'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")            
        else if k>0
          $('.variant1 #handle'+i).append(res[k]) 
        
        if k+1 < j
          $('.variant2 #handle'+i).append(res[k]+"-")
                      
          $('.app').remove()
          $('.variant2 #handle'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
            
        else if k>0
          $('.variant2 #handle'+i).append(res[k])
          
          
          
        if k+1 < j
          $('.variant3 #handle'+i).append(res[k]+"_")
          $('.app').remove()
          $('.variant3 #handle'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
        else if k>0
          $('.variant3 #handle'+i).append(res[k])
        k++    
      j++
      i++
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
        i = 0
        j = 0

        proj_len = data['project'].length
        app_len = data['application'].length if typeof(data['application']) isnt 'undefined'
        text = "With this client will be deleted: \n"
        text += "Projects: "
        while j<proj_len
          text += data['project'][j]
          if j+1 isnt proj_len
            text+= ", "
          else text +="\n"
          j++
        if typeof(data['application']) isnt 'undefined'  
          text += "Applications: "
          
          while i<app_len
            text += data['application'][i]
            if i+1 isnt app_len
              text+= ", "
            else text +="\n"
            i++
        if(confirm(text))
          $.post "/admin/clients/" + id, {_method:'delete'}, (data) =>
            location.reload(true)
      else
        text = 'Are you sure?'
        if(confirm(text))
          $.post "/admin/clients/" + id, {_method:'delete'}, (data) =>
            location.reload(true)

    return false

   

