$ ->
  
  $('#app-list').modal(
          "backdrop" : "static",
          "keyboard" : true,
          'show' : false
          )
  verify.init('confirm')
 
  
  
  $('.close').text('×')
  
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
    ], 'class="table table-bordered table-app"')
  
  
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
    


        
  $('.error_proj').live 'click': ->
    $(this).val('')
    $(this).removeClass('error_proj')

      
  
  click = 0

  $(".get-list-applications").click ->
    
    if $(this).attr('class').match(/icon-chevron-down/)
      parent_id = $(this).parent().parent().attr('id')
      _pos = parent_id.indexOf('_')
      parent = parent_id.substring(_pos+1, parent_id.length)
      $('.tr_'+parent).remove()
      $(this).toggleClass('icon-chevron-down')
    else  
      $(this).toggleClass('icon-chevron-down')
  
      id = $(this).attr('id')
      if id isnt ''
        $.get '/admin/applications?get=product&id='+id, (data) =>
          count = Object.keys(data).length
          i = 0
          content =
            $tr([
                $td([
                  $table([
                    $tr([
                        $th('Application name')
                        $th('ID')
                        $th('Title')
                        $th('Bundle version')
                        $th('Bundle identifier')
                        $th('Relative path')
                        $th('Actions')
                      ],'class="tr_'+id+'"')
                    ],'width="100%" class="table_no_border-left table_'+id+'"')
                  $table([
                    $tr([
                      $td([
                        $link_to('','#','class="icon-plus pull-right add_new" id="'+id+'" style="margin-right:5px;"')
                        ],'colspan="5" style="background-color: rgba(204,204,204, 0.3);"')
                      ])
                    ],'width="100%"')
                  ], 'colspan="5"')
              ], 'class="tr_'+id+'"')
            
          $(this).parent().parent().eq(0).after(content)

          while i < count
            link = []
            link[0] = $link_to('', '#', 'id="'+data[i].id+'" class="icon-pencil edit-link" style="color:black;"')
            link[1] = $link_to('', '#', 'rel="nofollow" style="color:black;" class="icon-trash tr_delete_" id="'+data[i].id+'"')
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
            ])
            
            $('.table_'+id+' tbody').append(content[i])
 
            
            if i+1 isnt count
              $(this).next().append(", ")
            i+=1
   
  $('.edit-link').live 'click': ->
    id = $(this).attr('id')
    $('#app-list').modal('show':true)

      
    $.get '/admin/applications?get=app&id='+id, (data) =>
                         
      $('#app-title').empty()
      $('#app-title').append('Application: '+data.product_name)
      $('.index-content').empty()
      $('.index-content').append(getChildren('.form_for_index'))
      #inialize params
      $('.edit_application').attr('action','/admin/remote_update/'+id)
      $('.edit_application').attr('id', 'edit_application_'+id)
      $('#application_product_name').val(data.product_name)
      $('#application_bundle_identifier').val(data.bundle_identifier)
      $('#application_bundle_version').val(data.bundle_version)
      $('#application_relative_path').val(data.relative_path)
      $('#application_title').val(data.title)
      #end
      
      
      
     
      $('#handle_store_edit').text($('input[id="application_relative_path"]').val())    
      
      
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
        while i<count
          $('#application_project_name').append(
            '<option id="'+proj[i].id+'" value="'+proj[i].id+'">'+proj[i].name+'</option>'
          )
          i++
        $('#application_project_name #'+data.project_id).attr('selected':'selected')


  $('.tr_delete_').live 'click': ->

    id = $(@).attr('id')
    verify.run('confirm','Do you realy want to delete this application?')
    $('#yes_btn').click ->
      $.get '/admin/applications?method=delete&app_id='+id, (data) =>
        $.post "/admin/applications/" + id, {_method:'delete'}, (data) =>
          document.location.reload(true)
          #$('.tr_delete_ #'+id).parent().parent().parent().remove()

    
    
  
  $('#duplicate').live 'click': ->
    $('a[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      document.location.reload(true)
  
  
  
  $('.add_new').live 'click': ->
    $('.notice-admin').empty()
    $('.relative-variant').empty()
    id = $(this).attr('id')
   
    
    parent_el = $(this).parent().parent().parent().parent()
    
    if parent_el.children().eq(1).length isnt 0
      parent_el.children().eq(1).remove()

    else
      
      
      $.get '/admin/projects?project_id='+id, (data) =>
        $('#relative_store').text(data.handle) 
      
            
      
      parent_el.append(
        '<table style="margin: 0 auto; width:100%;" class="table table-bordered open-new-app"><tr><td id="append_'+id+'"></td></tr></table>')
      
      $('#append_'+id).append($('#proj_'+id).html())
      
      
      
  $('#application_product_name').live 'input': ->
    place = $(this).parent().parent().parent()
    $('.relative-variant').empty()
    name = $(this).val().toLowerCase()
    res = name.split(" ")
    try
      application_class = $(this).next().attr('class').replace(/\s+/g, '')
    catch e
      application_class = ''
      
    getRelativePath(res, application_class, place)
    
    
    
    $('div[id*="relative"]').mousemove ->
      $(this).css('cursor':'pointer', 'text-decoration':'underline')
    $('div[id*="relative"]').mouseleave ->
      $(this).css('text-decoration':'none')
      
    $('div[id*="relative"]').click ->
      place = $(this).parent().parent().parent()
      
      name_app = $(this).text().toLowerCase().replace(/\s+/g,'')

      relative = $('#handle_store_edit').text().replace(/\s+/g,'')
  
      num_slash = relative.lastIndexOf('/')
    
      store_project = relative.substring(0, num_slash)
      
      
      if $(this).attr('class') isnt ''
        idh = $(this).attr('class')
        store_project = $('#project_handle_'+idh).text().toLowerCase().replace(/\s+/g,'')
      
      place.find('input[id="application_relative_path"]').val(store_project+"/"+name_app)

      
  $('#application_project_name option').live 'click': ->
    id = $(this).val()
    store_project = $('#project_handle_'+id).text().toLowerCase().replace(/\s+/g,'')

    relative = $('#handle_store_edit').text().replace(/\s+/g,'')
  
    num_slash = relative.lastIndexOf('/')
    
    name_app = relative.substring(num_slash+1, relative.length)
    $('#application_relative_path').val(store_project+"/"+name_app)



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
      if typeof(errors.bundle_identifier) isnt 'undefined'  
        par.find('#application_bundle_identifier').val(errors.bundle_identifier).addClass('error_proj')
      
        
    
    $('.error_proj').click ->
      $(this).val('')
      $(this).removeClass('error_proj')
        
  $('.notice-admin').mousemove ->
    $(this).empty()