$ ->

  $('#client-list').modal(
    "backdrop" : "static",
    "keyboard" : true,
    'show' : false
    )
	

  $('#add-new-client').hide()


  
  
  $('#add-client-btn').click ->
    $('.handle-variant').empty()
    $('#client_name').val('')
    $('#client_email').val('')
    $('#client_handle').val('')
    $('.companies-notice').empty()
    $('#add-new-client').show()
    $('.show-btn').hide()
  $('#hide_btn').click ->
    $('input').removeClass('field_with_errors')
    $('#add-new-client').hide()
    $('.show-btn').show()
    

  $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
          
    $('.companies-notice').empty()
    $('.companies-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Handle was success create!</span>')    
    $('.client_list').empty()     
    count = Object.keys(data).length
    i = 0
    while i < count
      $('.client_list').append("<a id='"+data[i].id+"' class='prev-client'>"+data[i].name+"</a>")
      if i+1 isnt count
        $('.client_list').append(", ")
      i += 1
      
      
  $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
    $('.notice-project').empty()
    errors = $.parseJSON(data.responseText)

    if typeof(errors.name) isnt 'undefined'
      $('#client_name').val(errors.name).addClass('error_proj')
    if typeof(errors.email) isnt 'undefined'  
      $('#client_email').val(errors.email).addClass('error_proj')
    if typeof(errors.handle) isnt 'undefined'  
      $('#client_handle').val(errors.handle).addClass('error_proj')
    
  $('.error_proj').live 'click': ->
    $(this).val('')
    $(this).removeClass('error_proj')


  append_html = (data) ->
    $('.clients-content').empty()
    $table([
      $div([
        $tr([
          $th('ID')
          $td(data.id)
        ])
        $tr([
          $th('Client name')
          $td(data.name)
        ], 'class="show-and-edit-app" id="client_name"')
        $tr([
          $th('Email')
          $td(data.email)
        ], 'class="show-and-edit-app" id="client_email"')
        $tr([
          $th('Handle')
          $td(data.handle)
        ], 'class="show-and-edit-app" id="client_handle"')
        $tr([
          $th('Action')
          $td([
            $link_to('Edit','#', 'id="edit_'+data.id+'" class="btn btn-small"')
            $link_to('Destroy','/admin/clients/'+data.id,'rel="nofollow" data-method="delete" data-remote="true" class="btn btn-small" data-confirm="Are you sure?" id="delete_'+data.id+'"')
          ])
        ])

      ], 'class="notice-client"')
    
    ], 'class="table table-bordered table-app"')

  $('.prev-client').live 'click': ->
    $('.notice-app').empty()
    $('.clients-content').empty()
    $('#client-title').empty()
    $('#client-list').modal('show':true)
    id = $(this).attr('id')
    $.get '/admin/clients?get=client&id='+id, (data) =>
      $('#client-title').append('Client: '+data.name)
      $('.clients-content').empty()
      $('.clients-content').append(append_html(data))
    $('#delete_'+id).live 'click': ->
      location.reload(true)


    $('#edit_'+id).live 'click': ->

      $.get '/admin/clients?get=client&id='+id, (data) =>
        $('.clients-content').empty()
        $('.clients-content').append(getChildren('.form_edit_company'))
        $('.edit_client').attr('action', '/admin/client_remote_update/'+id)
        $('.edit_client').attr('id','edit_client_'+id)
        $('input[id="client_name"]').val(data.name)
        $('#client_email').val(data.email)
        $('#client_handle').val(data.handle)
        
        $.get '/admin/companies.json', (company) =>
          $('#client_company_id').empty()
          count = Object.keys(company).length

          i = 0
          while i<count
            $('#client_company_id').append(
              '<option id="'+company[i].id+'" value="'+company[i].id+'">'+company[i].name+'</option>'
            )
            i++
          $('#client_company_id #'+data.company_id).attr('selected':'selected')


        
        $('form[data-remote]').live "ajax:success", (evt, data, status, xhr) ->
          $('.clients-content').empty()
          $('.clients-content').append(append_html(data))
          $('.notice-client').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Cleint was success update!</span>')    
          $('.notice-client').mousemove ->
            $(this).empty()
  
        $('form[data-remote]').live "ajax:error", (event, data, status, xhr) ->
          $('.notice-client').empty()
          errors = $.parseJSON(data.responseText)
          if typeof(errors.name) isnt 'undefined'
            $('#client_name input').val(errors.name).addClass('error_proj')
          if typeof(errors.email) isnt 'undefined'  
            $('#client_email').val(errors.email).addClass('error_proj')
          if typeof(errors.handle) isnt 'undefined'  
            $('#client_handle').val(errors.handle).addClass('error_proj')
          
      $('.notice-client').empty()

        


  $('#client_name').live 'input': ->


    name = $(this).val().toLowerCase()
    name = name.trim()
    if typeof(name[0]) isnt 'undefined'
      $('.handle-variant').empty()
    res = name.split(" ")

    j = 1;i = 0;variant = 4;count = 0
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
      

      
      
    $('div[id*="handle"]').live 'click': ->
      
      company = $('#company_name').text().toLowerCase().replace(/\s+/g,'')
        
      $('#client_handle').val(company+'/'+$(this).text().replace(/\s+/g,''))





  $('.btn-delete-company').click ->
    id = $(@).attr('id')

    $.get '/admin/companies?type=relations&id='+id, (data) =>
      client_length = data['clients'][0].length
      project_length = data['project'][0].length if typeof(data['project']) isnt 'undefined'
      application_length = data['application'].length if typeof(data['application']) isnt 'undefined'
      i=0;j=0;k=0
      if client_length > 0
        text = "Do you really want delete this company? \n"
        text += "Clients: "
        while i<client_length
          text += data['clients'][0][i].name
          text += ", " if i+1 isnt client_length
          i++
        if typeof(data['project']) isnt 'undefined'
          text += "\nProjects: "
          while j < project_length
            text += data['project'][0][j].name
            text += ", " if j+1 isnt project_length
            j++
        if typeof(data['application']) isnt 'undefined'
          text += "\nApplication: "
          while k < application_length
            text += data['application'][k]
            text += ", " if k+1 isnt application_length
            k++

        if confirm(text)
          $.post "/admin/companies/" + id, {_method:'delete'}, (data) =>
            location.reload(true)
      else
        text = "Are you sure?"
        if confirm(text)
          $.post "/admin/companies/" + id, {_method:'delete'}, (data) =>
            location.reload(true)






