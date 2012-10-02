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

    $.get '/admin/applications?ch=true&val='+$(this).val(), (data) =>
      count = Object.keys(data).length
      #$('#wait').remove()
      $('#res').remove()
      if count is 0
        $(this).after('<span id="res" style="color:green">&nbsp;&nbsp;<i class="icon-ok-sign"></i></span>')
      else
        $(this).after('<div id="res" style="color:red">This value already taken!</div>')
  
  
  
  
  
  
  
  
  $('#new-application').hide()
  
  
  $('#show-btn').click ->
    $('.notice-project').empty()
    $('#new-application').show()
    $('.show-btn').hide()
  
  
  $('#hide_btn').click ->
    $('.notice-project').empty()
    $('#new-application').hide()
    $('.show-btn').show()

  
  
  
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
          $(this).parent().parent().eq(0).after('
          <tr class="tr_'+id+'">
            <td colspan="7">
            <table width="100%" class="table_no_border-left table_'+id+'">
            
              <tr class="tr_'+id+'">
                <th>Application name</th>
                <th>ID</th>
                <th>Title</th>
                <th>Bundle version</th>
                <th>Bundle identifier</th>
                <th>Relative path</th>
                <th>Actions</th>    
              </tr>
              
            </table>
            <table width="100%" class="table_no_border-left">
              <tr>
                <td colspan="7" style="background-color: rgba(204,204,204, 0.3);">
                  <a class="icon-plus pull-right add_new" id="'+id+'" style="margin-right:5px;"></a>
                </td>
              </tr>
            </table>
            </td>
          </tr>
            ')

          while i < count 
            $('.table_'+id+' tbody').append('
              <tr>

                <td id="app-name-td_'+data[i].id+'">
                  <a id="'+data[i].id+'" class="prev-app">'+data[i].product_name+'</a>
                </td>
                
                <td>
                  '+data[i].id+'
                </td>
                
                <td>
                  '+data[i].title+'
                </td>
                
                <td>
                   '+data[i].bundle_version+'
                </td>
                
                <td>
                   '+data[i].bundle_identifier+'
                </td>
                
                <td>
                   '+data[i].relative_path+'
                </td>
                
                <td width="50">
                  <div class="app-panel pull-right">
                    <a id="'+data[i].id+'"class="icon-pencil edit-link" href="#" style="color:black;"></a>&nbsp;
                    <a rel="nofollow" style="color:black;" class="icon-trash" data-method="delete" data-remote="true" data-confirm="Are you sure?" id="tr_delete_" href="/admin/applications/'+data[i].id+'?proj='+data[i].project_id+'"></a>&nbsp
                    <a class="icon-retweet" style="color:black;" href="/admin/applications?meth=clone&id='+data[i].id+'" id="duplicate" data-remote="true" title="Make duplicate" data-confirm="Are you sure?"></a>
                   </div>
                </td>
              </tr>

              ')
 
            
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
    insert_text = '
        <table class="table table-bordered table-app">
        <div class="notice-app"></div>
          <tr>
            <th>ID</th>
            <td>'+data.id+'</td>
          </tr>
          <tr>
            <th>Product name</th>
            <td class="show-and-edit-app" id="product_name">'+data.product_name+'</td>
          </tr>
          <tr>
            <th>Bundle identifier</th>
            <td class="show-and-edit-app" id="bundle_identifier">'+data.bundle_identifier+'</td>
          </tr>
          <tr>
            <th>Bundle version</th>
            <td class="show-and-edit-app" id="bundle_version">'+data.bundle_version+'</td>
          </tr>
          <tr>
            <th>Relative path</th>
            <td class="show-and-edit-app" id="relative_path">'+data.relative_path+'</td>
          </tr>
          <tr>
            <th>Title</th>
            <td class="show-and-edit-app" id="title">'+data.title+'</td>
          </tr>
          <tr>
            <th>Action</th>
            <td>
              <a id="'+data.id+'" class="edit-link btn btn-small">Edit</a>
              &nbsp;
              <a rel="nofollow" data-method="delete" data-remote="true" class="btn btn-small" data-confirm="Are you sure?" id="delete_'+data.id+'" href="/admin/applications/'+data.id+'?proj='+data.project_id+'">Destroy</a>
            </td>
          </tr>
        </table>
        '
  
  
  
  
  
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
      $('.index-content').append('
       <form accept-charset="UTF-8" action="/admin/remote_update/'+id+'" data-remote="true" class="edit_application" id="edit_application_'+id+'" method="post">
        <table class="table table-bordered table-app">
            <tr>
            <th>Project</th>
            <td class="show-and-edit-app" id="id">
              <select name="application[project_id]" id="application_project_name"></select>
            </td>
          </tr>
            <tr>
              <th>Product name</th>
              <td class="show-and-edit-app" id="product_name"><input id="application_product_name" name="application[product_name]" size="30" type="text" value="'+data.product_name+'" /></td>
            </tr>
            <tr>
              <th>Bundle identifier</th>
              <td class="show-and-edit-app" id="bundle_identifier"> <input id="application_bundle_identifier" name="application[bundle_identifier]" size="30" type="text" value="'+data.bundle_identifier+'" /></td>
            </tr>
            <tr>
              <th>Bundle version</th>
              <td class="show-and-edit-app" id="bundle_version"> <input id="application_bundle_version" name="application[bundle_version]" size="30" type="text" value="'+data.bundle_version+'" /></td>
            </tr>
            <tr>
              <th>Relative path</th>
              <td class="show-and-edit-app" id="relative_path"> <input id="application_relative_path" class="input-xlarge" name="application[relative_path]" size="30" type="text" value="'+data.relative_path+'" />
                <div class="relative-variant"></div>
              </td>
            </tr>
            <tr>
              <th>Title</th>
              <td class="show-and-edit-app" id="title"><input id="application_title" name="application[title]" size="30" type="text" value="'+data.title+'" /></td>
            </tr>
            <tr>
              <th>Action</th>
              <td>
                <input class="btn" name="commit" type="submit" value="Save" />
              </td>
            </tr>
        </table>
      </form>
        ')
      
      
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
    parent_el = $(this).parent().parent().parent().parent()
    
    if parent_el.children().eq(1).length isnt 0
      parent_el.children().eq(1).remove()

    else
      
      
      $.get '/admin/projects?p='+id, (data) =>
        $('#relative_store').text(data.handle) 
      
            
      
      parent_el.append(
        '<table style="margin: 0 auto; width:100%;" class="table table-bordered open-new-app">
          <tr>
            <td id="append_'+id+'">
            </td>
          </tr>
        </table>'            
      )
      
      $('#append_'+id).append($('#proj_'+id).html()) 
    
    
  $('#project_name').bind 'input': ->
    $('.proj-h-variants').empty()
    client = $('#project_client_id :selected').text().toLowerCase().replace(/\s+/g,'')

    name = $(this).val().toLowerCase()
        
    res = name.split(" ")

    j = 1
    i = 0
    variant = 4
    count = 0
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
  
  ###### point
  
  
  $('.sort').css('color':'black')
  $('.sort').mousemove ->
    $(this).css('text-decoration':'none')
  fullpath = document.location.href
  
  isa = fullpath.indexOf('=')
  amp = fullpath.indexOf('&')
  type = fullpath.substring(isa+1, amp)
  
  
  sort = fullpath.lastIndexOf('=')
  sort = fullpath.substring(sort+1, fullpath.length)
  
  switch type
    when 'asc' 
      $('#'+sort).addClass('icon-chevron-up')
      $('#'+sort).parent().addClass('select-th')
    when 'desc' 
      $('#'+sort).addClass('icon-chevron-down')
      $('#'+sort).parent().addClass('select-th')  
  
  path_name = window.location.pathname
  if (/edit/).test(path_name)
    name = $('#autocomplete-client').val()

    id = $('#project_client_id:contains("'+name+'")').val()
    $.get '/admin/clients?handle='+id, (data) =>
      $('#client-handle').text(data.handle.replace(/\s/g,'')) 
   
  
  
  $('#tr_delete_').live 'click': ->
    $(this).parent().parent().parent().remove()
  
  $('#duplicate').live 'click': ->
    $('a[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      document.location.reload(true)
  
  
  
  $('.add-on').click ->

    $('#append-clients').empty()
    $('#append-clients').append($('.client_list').html())
    $('#append-clients').append('<li><a href="/admin/clients/new" target="blank" style="background-color:#cccccc;">Add new client</a></li>')
     
    $('.client_name_class').click ->
      client_name = $(this).text()
      client_name = ltrim(client_name)
      client_name = rtrim(client_name)
      $('#project_client_id option:contains("'+client_name+'")').attr('selected':'selected')
      $('#autocomplete-client').val(client_name)
      
      id = $(this).parent().attr('id')  
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


    $('.relative-variant').empty()
    name = $(this).val().toLowerCase()
    res = name.split(" ")
    j = 1
    i = 0
    variant = 4
    count = 0
    while count < variant
      $('.relative-variant').append("<div class='variant"+count+"'></div>")
      count++
    while i < res.length
      k = 0
      $('.variant0').append('<div id="relative'+i+'"></div>')
      $('.variant1').append('<div id="relative'+i+'"></div>')
      $('.variant2').append('<div id="relative'+i+'"></div>')
      $('.variant3').append('<div id="relative'+i+'"></div>')
      while k < j

        $('.variant0 #relative'+i).append(res[k])
        $('.app').remove()
        $('.variant0 #relative'+i).mousemove ->
          $('.app').remove()
          $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")

          
        if k+1 < j
          $('.variant1 #relative'+i).append(res[k]+".")
          
          
          
          $('.app').remove()
          $('.variant1 #relative'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
          
          
        else if k>0
          $('.variant1 #relative'+i).append(res[k])
        
        
        
        if k+1 < j
          $('.variant2 #relative'+i).append(res[k]+"-")
                      
          $('.app').remove()
          $('.variant2 #relative'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
            
        else if k>0
          $('.variant2 #relative'+i).append(res[k])
          
          
          
        if k+1 < j
          $('.variant3 #relative'+i).append(res[k]+"_")
          $('.app').remove()
          $('.variant3 #relative'+i).mousemove ->
            $('.app').remove()
            $(this).append("<span class='app'>&nbsp;&nbsp;<span class='icon-ok'></span></span>")
        else if k>0
          $('.variant3 #relative'+i).append(res[k])
        k++    
      j++
      i++
    $('div[id*="relative"]').mousemove ->
      $(this).css('cursor':'pointer', 'text-decoration':'underline')
    $('div[id*="relative"]').mouseleave ->
      $(this).css('text-decoration':'none')
      
    $('div[id*="relative"]').click ->
      
      relative =  $('input[id="application_relative_path"]').val().replace(/\s+/g,'')
      

      name_app = $(this).text().toLowerCase().replace(/\s+/g,'')
      store_project = $('#handle_store').text().toLowerCase().replace(/\s+/g,'')

      $('input[id="application_relative_path"]').val(store_project+"/"+name_app)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  $('.icon-ok').live 'click': ->
    value_rel = $(this).parent().children().eq(0).text()
    $('#application_relative_path').val(value_rel)
  
  
  
  
  #if $('#project_manager_id option').length > 1
  #  $('#project_manager_id').children().eq(1).attr('selected', 'selected')
    
  
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
  if(/edit/).test(path) or (/new/).test(path)
    id = $('#project_manager_id option:selected').val()
    $.get '/admin/developers?m='+id, (data) =>
      count = Object.keys(data).length
  
      i = 0
      while i < count
        $('.select_box_developers').append(
          '<span style="display:inline-block; border: 1px solid #cccccc; margin: 0px 2px 5px 0px; height:23px;">
            <span>'+data[i].name+'</span>
            <input type="checkbox" id="check_'+data[i].id+'" value="'+data[i].id+'">
          </span>'
          )  
        i++
      $('.select_box_developers input[type="checkbox"]').click ->
        val_dev = $(this).val()
        unless $(this).attr('checked')
          $('.dev_point input[value="'+val_dev+'"]').attr('checked',false)
        else
          $('.dev_point input[value="'+val_dev+'"]').attr('checked',true)
        
        
  $('#project_manager_id option').click ->
    id = $(this).val()
    if id is ''
      $('.select_box_developers').empty()
    else
      $.get '/admin/developers?m='+id, (data) =>
        count = Object.keys(data).length
        i = 0
        if count > 0
          $('.select_box_developers').empty()
          while i < count
            $('.select_box_developers').append(
              '<span style="display:inline-block; border: 1px solid #cccccc; margin: 0px 2px 5px 0px; height:23px;">
                <span>'+data[i].name+'</span>
                <input type="checkbox" id="check_'+data[i].id+'" value="'+data[i].id+'">
              </span>'
              )  
            i++
  $('.select_box_developers input[type="checkbox"]').click ->
    val_dev = $(this).val()
    unless $(this).attr('checked')
      $('.dev_point input[value="'+val_dev+'"]').attr('checked',false)
    else
      $('.dev_point input[value="'+val_dev+'"]').attr('checked',true)
      
  path = window.location.pathname

  if path is '/admin/projects/new'
    if $('#project_manager_id option').length > 1
      $('#project_manager_id option').eq(1).attr('selected','selected')
      $('#project_manager_id option').children().eq(1).attr('selecte','selected')