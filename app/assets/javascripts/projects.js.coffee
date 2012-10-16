$ ->
  $('#dev-list').modal(
    "backdrop" : "static",
    "keyboard" : true,
    'show' : false
    )
	
  
  $('#dev-link-remote').click ->
    $('.notice-app').empty()
    $('.dev-reload-notice').empty()
    name = $('#dev-input').val()
    $.get '/admin/developers/?developer_name='+name, (data) =>
      if typeof(data.id) isnt 'undefined'
        $('.searchable').append('<p><input type="checkbox" value="'+data.id+'" name="project[developer_ids][]" id="project_developer_ids_" disabled="disabled"><span>'+data.name+'</span>&nbsp;&nbsp;<span class="icon-exclamation-sign" style="color:red;"></span></p>')    
        $('.notice-app').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Developer was success update!</span>')    
        $('.dev-reload-notice').append('<a href="#" onclick="location.reload();">For apply changes please reload this page!</a>')
        $('.notice-app').mousemove ->
          $(this).empty()
      else
        $('#dev-input').addClass('error_proj').val('Can`t be blank!')

  
  
  $('#application_bundle_identifier').live 'input': ->

    $.get '/admin/applications?check=true&val='+$(this).val(), (data) =>
      count = Object.keys(data).length
      
      if $(this).val().length is 0
        $('#res').remove()
        $(this).after('<div id="res" style="color:red">Can\'t be blank!</div>')
        return false
      $('#res').remove()
      if count is 0
        $(this).after('<span id="res" style="color:green">&nbsp;&nbsp;<i class="icon-ok-sign"></i></span>')
      else
        $(this).after('<div id="res" style="color:red">This value already taken!</div>')
  
  
  
  
  
  
  
  
  $('#new-application').hide()
  
  
  $('.show-btn').click ->
    $('.notice-project').empty()
    $('#new-application').show()
    $('.show-btn').hide()
  
  
  $('#hide_btn').click ->
    $('.notice-project').empty()
    $('#new-application').hide()
    $('.show-btn').show()

  
  
  
  
  client_id =->
    result_handle = setTimeout ( ->
      client_name = $('#autocomplete-client').val()
      client_name = ltrim(client_name)
      client_name = rtrim(client_name)
      id = $('.client_name_class:contains("'+client_name+'")').parent().attr('id')

      
      if typeof(id) isnt 'undefined'
        $.get '/admin/clients?handle='+id, (data) =>
          $('#client-handle').text(data.handle.replace(/\s/g,''))
    
          ph_slash_len = $('#project_handle').val().split('/')
          if ph_slash_len.length > 1
            proj_h = $('#project_handle').val().replace(/\s/g,'')
            pos_proj_h = proj_h.lastIndexOf('/')
            substr_proj_h = proj_h.substring(pos_proj_h+1, proj_h.length)
            store = $('#client-handle').text().replace(/\s+/g,'')
            store = store+'/'+substr_proj_h
            $('#project_handle').val(store)
          $('.add_client_from_typehead').css('opacity':'0')
          return 'stop'
    ), 700

    if result_handle isnt 'stop'
      result_handle
      $('.add_client_from_typehead').css('opacity':'1')
      
  
  
  $('#autocomplete-client').bind 'input': ->

    client_id()
  
  
  
  
  $('.add_client_from_project').click ->
    if confirm('Do you really want to add this client to project handle?')
      client_name = $('#autocomplete-client').val().toLowerCase().replace(/\s+/g,'.')

      ph_slash_len = $('#project_handle').val().split('/')
      if ph_slash_len.length > 1
        proj_h = $('#project_handle').val().replace(/\s/g,'')
        pos_proj_h = proj_h.lastIndexOf('/')
        substr_proj_h = proj_h.substring(pos_proj_h+1, proj_h.length)
        store = client_name+'/'+substr_proj_h
        $('#project_handle').val(store)

  
  
  click = 0
  $(".get-list-applications").click ->
    if $(@).attr('class').match(/icon-chevron-down/)
      parent_id = $(@).parent().parent().attr('id')
      _pos = parent_id.indexOf('_')
      parent = parent_id.substring(_pos+1, parent_id.length)
      $('.tr_'+parent).remove()
      $(@).toggleClass('icon-chevron-down')
    else  
      $(@).toggleClass('icon-chevron-down')
  
      id = $(@).attr('id')
      if id isnt ''
        $.get '/admin/applications?get=product&id='+id, (data) =>
          count = Object.keys(data).length
          i = 0
          
          append_content = getChildren('.hidden-views-applications')
          
          buffer = []
            
          buffer.push(append_content)

          buffer[0] = buffer[0].replace('tr_waiting_id', 'tr_'+id)
          buffer[0] = buffer[0].replace('add_id', id)
          buffer[0] = buffer[0].replace('current-table', 'table_'+id)
          $(@).parent().parent().eq(0).after(buffer[0])

   
          while i < count
            link = []
            link[0] = $link_to('', '#', 'id="'+data[i].id+'" class="icon-pencil edit-link" style="color:black;"')
            link[1] = $link_to('', '/admin/applications/'+data[i].id, 'rel="nofollow" style="color:black;" class="icon-trash" data-method="delete" data-remote="true" data-confirm="Are you sure?" id="tr_delete_"')
            link[2] = $link_to('', '/admin/applications?method=clone&id='+data[i].id, 'class="icon-retweet" style="color:black;" id="duplicate" data-remote="true" title="Make duplicate" data-confirm="Are you sure?"')
            link = link.join(' ')
            
            content = []
            content[i] = $tr([  
              $td($link_to(data[i].product_name, '#', 'id="'+data[i].id+'" class="prev-app"'))
              $td(data[i].id)
              $td(data[i].title)
              $td(data[i].bundle_version)
              $td(data[i].bundle_identifier)
              $td(data[i].relative_path)
              $td($div(link,'class="app-panel pull-right"'), "width='50'")
            ],'<tr id="tr_'+id+'">')
 

            $('.table_'+id+' tbody').append(content[i])          

 
            
            if i+1 isnt count
              $(this).next().append(", ")
            i+=1

  
  $('#app-list').modal(
          "backdrop" : "static",
          "keyboard" : true,
          'show' : false
          )
  
 
  
  
  append_html = (data) ->
    $('.index-content').empty()

    insert_text = $table([
      $div('', "class='notice-app'")
      $tr([$th('ID'), $td(data.id)])
      $tr([$th('Product name'), $td(data.product_name)], 'class="show-and-edit-app" id="product_name"')
      $tr([$th('Bundle identifier'), $td(data.bundle_identifier)], 'class="show-and-edit-app" id="bundle_identifier"')
      $tr([$th('Bundle version'), $td(data.bundle_version)], 'class="show-and-edit-app" id="bundle_version"')
      $tr([$th('Relative path'), $td(data.relative_path)], 'class="show-and-edit-app" id="relative_path"')
      $tr([$th('Title'), $td(data.title)], 'class="show-and-edit-app" id="title"')
      $tr([$th('Action'), $td([$link_to('Edit', '#', 'id="'+data.id+'" class="edit-link btn btn-small"'), $link_to('Destroy', '/admin/applications/'+data.id+'?proj='+data.project_id, 'rel="nofollow" data-method="delete" data-remote="true" class="btn btn-small" data-confirm="Are you sure?" id="delete_'+data.id+'"')])])   
    ],'class="table table-bordered table-app"')
  
  
  
  $('.prev-app').live 'click': ->
    $('.notice-app').empty()
    $('.index-content').empty()
    $('#app-title').empty()
    $('#app-list').modal('show':true)
    id = $(this).attr('id')
    $.get '/admin/applications?get=app&id='+id, (data) =>
      $('#app-title').append('Application: '+data.product_name)
      $('.index-content').empty()

      $('.index-content').append(append_html(data))


        
    
     
  $('.edit-link').live 'click': ->
    
    
    id = $(this).attr('id')
    $('#app-list').modal('show':true)

    $.get '/admin/applications?get=app&id='+id, (data) =>
      $('.index-content').empty()
      edit_form = $('.edit_form').html()
      $('.index-content').append(edit_form)
      
      #inialize params
      $('.edit_application').attr('action','/admin/remote_update/'+id)
      $('.edit_application').attr('id', 'edit_application_'+id)
      $('#application_product_name').val(data.product_name)
      $('#application_bundle_identifier').val(data.bundle_identifier)
      $('#application_bundle_version').val(data.bundle_version)
      $('#application_relative_path').val(data.relative_path)
      $('#application_title').val(data.title)
      #end
      
      $('#handle_store_edit').text($('#application_relative_path').val())
      
      $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
        $('.index-content').empty()
        $('.index-content').append(append_html(data))
        $('.notice-app').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Application was success update!</span>')    
        $('.notice-app').mousemove ->
          $(this).empty()

      $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
        $('.notice-project').empty()
        errors = $.parseJSON(data.responseText)
        if typeof(errors.title) isnt 'undefined'
          $('#application_title').val(errors.title).addClass('error_proj')
        if typeof(errors.product_name) isnt 'undefined'  
          $('#application_product_name').val(errors.product_name).addClass('error_proj')
          
      $('.notice-app').empty()
      
      $.get '/admin/projects.json', (proj) =>
        $('#application_project_name').empty()
        count = Object.keys(proj).length
        i = 0
        j = 0
        while i<count
          $('#application_project_name').append(
            '<option id="'+proj[i].id+'" value="'+proj[i].id+'">'+proj[i].name+'</option>'
          )
          i++
        $('#application_project_name #'+data.project_id).attr('selected':'selected')
       
        while j<count
          $('#project_handle_store').append('<span id="project_handle_'+proj[j].id+'">'+proj[j].handle+'</span>')
          j++
        
        
        


        
  $('.error_proj').live 'click': ->
    $(this).val('')
    $(this).removeClass('error_proj')
  

  
  $('#show-dev').click ->
    $('#dev-list').modal(show:true)
    $('#dev-input').val('')
  $('input[type="checkbox"]:checked + span').each ->
    $('.select-dev-list').append("[ "+$(this).text()+" ]")
    
  $('#add-dev-btn').click ->
    $('.select-dev-list').empty()
    $('input[type="checkbox"]:checked + span').each ->
      $('.select-dev-list').append("[ "+$(this).text()+" ]")
      
  
  
  
  $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
          
    document.location.reload(true)
      
      
  $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
    $('.notice-project').empty()
    errors = $.parseJSON(data.responseText)

    if typeof(errors.title) isnt 'undefined'
      $('#application_title').val(errors.title).addClass('error_proj')
    if typeof(errors.product_name) isnt 'undefined'  
      $('#application_product_name').val(errors.product_name).addClass('error_proj')
    
      
  
  $('.error_proj').click ->
    $(this).val('')
    $(this).removeClass('error_proj')
   
   
   
  $('#save-new-app').live 'click': ->

    $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
            
      $('.notice-admin').empty()
      $('.notice-admin').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Handle was success create!</span>')    
          
        
    $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
      $('.notice-admin').empty()
      errors = $.parseJSON(data.responseText)
      par = $(this).parent().children()
      if typeof(errors.title) isnt 'undefined'
        par.find('#application_title').val(errors.title).addClass('error_proj')
      if typeof(errors.product_name) isnt 'undefined'  
        par.find('#application_product_name').val(errors.product_name).addClass('error_proj') 
   
   
  $('.add_new').live 'click': ->
    $('.notice-admin').empty()
    $('.relative-variant').empty()
    id = $(this).attr('id')
    $('input[id="application_relative_path"]').val('')
    $('input[id="application_product_name"]').val('')
    parent_el = $(this).parent().parent().parent().parent()
    
    if parent_el.children().eq(1).length isnt 0
      parent_el.children().eq(1).remove()

    else
      
      
      $.get '/admin/projects?project_id='+id, (data) =>
        $('#relative_store').text(data.handle) 
      
            
      
      parent_el.append('<table style="margin: 0 auto; width:100%;" class="table table-bordered open-new-app"><tr><td id="append_'+id+'"></td></tr></table>')
      
      $('#append_'+id).append($('#proj_'+id).html()) 
  
  $('.add_client_from_typehead').css('opacity':'0')
  
  $('#autocomplete-client').bind 'input': ->
    attr_style = $('.typeahead').attr('style')

    if (/none/).test(attr_style) or typeof(attr_style) is 'undefined'
      
      $('.add_client_from_project').click ->
        auto_client = $('#autocomplete-client').val().replace(/\s+/g,'')

      $('.add_client_from_typehead').animate('opacity':'1',500)
    else $('.add_client_from_typehead').css('opacity':'0')
      
   
  $('#project_name').bind 'input': ->
    $('.proj-h-variants').empty()
    client = $('#project_client_id :selected').text().toLowerCase().replace(/\s+/g,'')

    name = $(this).val().toLowerCase()
        
    res = name.split(" ")

    j = 1;i = 0;variant = 4;count = 0
    while count < variant
      $('.proj-h-variants').append("<div class='variant"+count+"'></div>")
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
      $('#project_handle').val('')
      store = $('#client-handle').text().replace(/\s+/g,'')
      store = store+'/'+$(this).text().toLowerCase().replace(/\s+/g,'')
      $('#project_handle').val(store)
  
  
  path_name = window.location.pathname
  if (/edit/).test(path_name)
    name = $('#autocomplete-client').val()
    if name isnt ''
      id = $('#project_client_id:contains("'+name+'")').val()
      if typeof(id) isnt 'undefined'
        $.get '/admin/clients?handle='+id, (data) =>
          $('#client-handle').text(data.handle.replace(/\s/g,'')) 
     
  
  $('#tr_delete_').live 'click': ->
    $(this).parent().parent().parent().remove()
  
  $('#duplicate').live 'click': ->
    $('a[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      document.location.reload(true)
  
  
  
  $('.add-on').live 'click': ->

    $('#append-clients').empty()
    $('#append-clients').append($('.client_list').html())
    $('#append-clients').append('<li><a href="/admin/clients/new" target="_blank" style="background-color:#cccccc;">Add new client</a></li>')
     
    $('.client_name_class').click ->
      client_name = $(this).text()
      client_name = ltrim(client_name)
      client_name = rtrim(client_name)
      $('#project_client_id option:contains("'+client_name+'")').attr('selected':'selected')
      $('#autocomplete-client').val(client_name)
      
      id = $(this).parent().attr('id')
      if typeof(id) isnt 'undefined'
        $.get '/admin/clients?handle='+id, (data) =>
          $('#client-handle').text(data.handle.replace(/\s/g,''))        
  
          ph_slash_len = $('#project_handle').val().split('/')
          if ph_slash_len.length > 1
            proj_h = $('#project_handle').val().replace(/\s/g,'')
            pos_proj_h = proj_h.lastIndexOf('/')
            substr_proj_h = proj_h.substring(pos_proj_h+1, proj_h.length)
            store = $('#client-handle').text().replace(/\s+/g,'')
            store = store+'/'+substr_proj_h
            $('#project_handle').val(store)
       
      ######### end point
      
  

  
  
  
  
  $('#application_product_name').live 'input': ->
    place = $(this).parent().parent().parent()
    $('.relative-variant').empty()
    name = $(this).val().toLowerCase()
    res = name.split(" ")
    j = 1
    i = 0
    variant = 4
    
    try
      cl = $(this).next().attr('class').replace(/\s+/g, '')
    catch e
      cl = ''
      
      
    count = 0
    while count < variant
      place.find('.relative-variant').append("<div class='variant"+count+"'></div>")
      count++
    while i < res.length
      k = 0
      place.find('.variant0').append('<div id="relative'+i+'" class="'+cl+'"></div>')
      place.find('.variant1').append('<div id="relative'+i+'" class="'+cl+'"></div>')
      place.find('.variant2').append('<div id="relative'+i+'" class="'+cl+'"></div>')
      place.find('.variant3').append('<div id="relative'+i+'" class="'+cl+'"></div>')
      while k < j

        place.find('.variant0 #relative'+i).append(res[k])
        $('.app').remove()
        place.find('.variant0 #relative'+i).mousemove ->
          $('.app').remove()
          $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")

          
        if k+1 < j
          place.find('.variant1 #relative'+i).append(res[k]+".")
          
          
          
          $('.app').remove()
          place.find('.variant1 #relative'+i).mousemove ->
            place.find('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
          
          
        else if k>0
          place.find('.variant1 #relative'+i).append(res[k])
        
        
        
        if k+1 < j
          place.find('.variant2 #relative'+i).append(res[k]+"-")
                      
          $('.app').remove()
          place.find('.variant2 #relative'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
            
        else if k>0
          place.find('.variant2 #relative'+i).append(res[k])
          
          
          
        if k+1 < j
          place.find('.variant3 #relative'+i).append(res[k]+"_")
          $('.app').remove()
          place.find('.variant3 #relative'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
        else if k>0
          place.find('.variant3 #relative'+i).append(res[k])
        k++    
      j++
      i++
    $('div[id*="relative"]').mousemove ->
      $(this).css('cursor':'pointer', 'text-decoration':'underline')
    $('div[id*="relative"]').mouseleave ->
      $(this).css('text-decoration':'none')
  
  $('#application_project_name option').live 'click': ->
    id = $(this).val()
    store_project = $('#project_handle_'+id).text().toLowerCase().replace(/\s+/g,'')

    relative = $('#handle_store_edit').text().replace(/\s+/g,'')
  
    num_slash = relative.lastIndexOf('/')
    
    name_app = relative.substring(num_slash+1, relative.length)
    $('#application_relative_path').val(store_project+"/"+name_app)
    
    
      
  $('div[id*="relative"]').live 'click': ->
    place = $(this).parent().parent().parent()
    name_app = $(this).text().toLowerCase().replace(/\s+/g,'')

    relative = $('#handle_store_edit').text().replace(/\s+/g,'')

    num_slash = relative.lastIndexOf('/')
  
    store_project = relative.substring(0, num_slash)
    
    if $(this).attr('class') isnt ''
      idh = $(this).attr('class')
      store_project = $('#project_handle_'+idh).text().toLowerCase().replace(/\s+/g,'')
    
    path = window.location.pathname
    
    if (/projects\/\d/).test(path)
      store_project = $('#handle_store_content').text().toLowerCase().replace(/\s+/g,'')
      
      
    place.find('input[id="application_relative_path"]').val(store_project+"/"+name_app)

    
  $('.icon-ok').live 'click': ->
    value_rel = $(this).parent().children().eq(0).text()
    $('#application_relative_path').val(value_rel)
  
    
  
  $.get '/admin/clients.json', (data) =>
    
    subjects = []
    count = Object.keys(data).length
    i = 0
    while i < count  
      subjects.push(data[i].name)
      i++

    $('#autocomplete-client').typeahead(source: subjects)
  
  
  $('#autocomplete-client').val($('#project_client_id option[selected="selected"]').text())
    
  $('#autocomplete-client').bind 'input': ->
    client_name = $(this).val()
    $('#project_client_id option:contains("'+client_name+'")').attr('selected':'selected')
  
  path = window.location.pathname;
  get_all_dev = ->
    id = $('#project_manager_id option:selected').val()
    if typeof(id) isnt 'undefined'

      $.get '/admin/developers?manager_id='+id, (data) =>
        count = Object.keys(data).length
        i = 0
        if count > 0
          while i < count
            $('.select_box_developers').append('<span style="display:inline-block; border: 1px solid #cccccc; margin: 0px 2px 5px 0px; height:23px;"><span>'+data[i].name+'</span><input type="checkbox" id="check_'+data[i].id+'" value="'+data[i].id+'"></span>')  
            i++
          $('.select_box_developers input[type="checkbox"]').click ->
            val_dev = $(this).val()
            unless $(this).attr('checked')
              $('.dev_point input[value="'+val_dev+'"]').attr('checked',false)
            else
              $('.dev_point input[value="'+val_dev+'"]').attr('checked',true)
        else
          $('.select_box_developers').empty()
          $('.select_box_developers').append('Deverlopers not found!')
          
    else return true
      
  setTimeout get_all_dev, 300
        
        
  $('#project_manager_id option').click ->
    id = $(this).val()
    if id is ''
      $('.select_box_developers').empty()
    else
      $.get '/admin/developers?manager_id='+id, (data) =>
        count = Object.keys(data).length
        i = 0
        if count > 0
          $('.select_box_developers').empty()
          while i < count
            $('.select_box_developers').append('<span style="display:inline-block; border: 1px solid #cccccc; margin: 0px 2px 5px 0px; height:23px;"><span>'+data[i].name+'</span><input type="checkbox" id="check_'+data[i].id+'" value="'+data[i].id+'"></span>')  
            i++
        else
          $('.select_box_developers').empty()
          $('.select_box_developers').append('Deverlopers not found!')
  $('.select_box_developers input[type="checkbox"]').click ->
    val_dev = $(this).val()
    unless $(this).attr('checked')
      $('.dev_point input[value="'+val_dev+'"]').attr('checked',false)
    else
      $('.dev_point input[value="'+val_dev+'"]').attr('checked',true)
      
  path = window.location.pathname

  if path is '/admin/projects/new' or (/edit/).test(path)
    if $('#project_manager_id option').length > 1 or $('#project_manager_id option:selected').val is ''
      $('#project_manager_id option').eq(1).attr('selected','selected')
      $('#project_manager_id option').children().eq(1).attr('selecte','selected')