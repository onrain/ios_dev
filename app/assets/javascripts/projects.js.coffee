$ ->
  $('#dev-list').modal(
    "backdrop" : "static",
    "keyboard" : true,
    'show' : false
    )
	
  
  
  
  
  
  $('#application_bundle_identifier').bind 'input': ->
    $('#wait').remove()
    #$(this).after('<span id="wait">&nbsp;&nbsp;<img src="/assets/load.gif"></span>');
    $.get '/admin/applications?ch=true&val='+$(this).val(), (data) =>
      count = Object.keys(data).length
      #$('#wait').remove()
      $('#res').remove()
      if count is 0
        $(this).after('&nbsp;&nbsp;<div id="res" style="color:green">Alright!</div>')
      else
        $(this).after('&nbsp;&nbsp;<div id="res" style="color:red">This value already taken!</div>')
  
  
  
  
  
  
  
  
  $('#new-application').hide()
  
  
  $('#show-btn').click ->
    $('.notice-project').empty()
    $('#new-application').show()
    $('#show-btn').hide()
  
  
  $('#hide_btn').click ->
    $('.notice-project').empty()
    $('#new-application').hide()
    $('#show-btn').show()

  
  
  
  click = 0
  $(".get-list-applications").click ->
    if click is 0
      click +=1
      id = $(this).attr('id')
      if id isnt ''
        $.get '/admin/applications?get=product&id='+id, (data) =>
          count = Object.keys(data).length
          i = 0
          if typeof(data[0]) is 'undefined'
            $(this).next().append("empty.")
          else
            $(this).next().append("<hr />")
            while i < count
              
              $(this).next().append("<a id='"+data[i].id+"' class='prev-app'>"+data[i].product_name+"</a>")
              if i+1 isnt count
                $(this).next().append(", ")
              i+=1
            

    else if click is 1
      $('.append-projects').empty()
      click = 0
  
  
  
  
  
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
            <th>Project ID</th>
            <td class="show-and-edit-app" id="project_id">'+data.project_id+'</td>
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
              <a id="edit_'+data.id+'"class="btn btn-small">Edit</a>
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
    
    

    $('#delete_'+id).live 'click': ->
      location.reload(true)


        
    
     
    $('#edit_'+id).live 'click': ->

      $.get '/admin/applications?get=app&id='+id, (data) =>
        $('.index-content').empty()
        $('.index-content').append('
         <form accept-charset="UTF-8" action="/admin/remote_update/'+id+'" data-remote="true" class="edit_application" id="edit_application_'+id+'" method="post">
          <table class="table table-bordered table-app">
              <tr>
                <th>Project ID</th>
                <td class="show-and-edit-app" id="id"><input id="application_project_name" name="application[project_id]" size="30" type="text" value="'+data.project_id+'" /></td>
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
                <td class="show-and-edit-app" id="relative_path"> <input id="application_relative_path" name="application[relative_path]" size="30" type="text" value="'+data.relative_path+'" /></td>
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
          
    $('.notice-project').empty()
    $('.notice-project').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Handle was success create!</span>')    
    $('.append-applications').empty()     
    count = Object.keys(data).length
    i = 0
    while i < count
      $('.append-applications').append("<a id='"+data[i].id+"' class='prev-app'>"+data[i].product_name+"</a>")
      if i+1 isnt count
        $('.append-applications').append(", ")
      i += 1
      
      
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  $('#project_name').bind 'input': ->
    $('.proj-h-variants').empty()
    client = $('#project_client_id :selected').text().toLowerCase().replace(/\s+/g,'')
    name = $(this).val().toLowerCase().replace(/\s+/g,'')
    clidot = $('#project_client_id :selected').text().toLowerCase().replace(/\s+/g,'.')
    namedot = $(this).val().toLowerCase().replace(/\s+/g,'.')
    $('.proj-h-variants').append(
      '<p><span id="handle"><span>'+name+'.<span class="cli_name">'+client+'</span></span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
      '<p><span id="handle"><span class="cli_name">'+client+'</span>.'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
      '<p><span id="handle"><span class="cli_name">'+client+'</span>'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
      '<p><span id="handle"><span class="cli_name">'+clidot+'</span>'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
      '<p><span id="handle"><span class="cli_name">'+client+'</span>_'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span>'
      '<p><span id="handle"><span class="cli_name">'+client.substring(0,3)+'</span>'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
    )
    
    
  $('#project_client_id option').click ->
    company = $(this).text().toLowerCase().replace(/\s+/g,'')
    $('.cli_name').empty()
    $('.cli_name').text(company)
    
  $('.icon-ok').live 'click': ->
    value_h = $(this).parent().children().eq(0).text()
    $('#project_handle').val(value_h)
  
  
  
  
  $('#application_product_name').bind 'input': ->

    $('.relative-variant').empty()
    client = $('#proj-client-h').text().toLowerCase().replace(/\s+/g,'')
    project = $('#proj-name').text().toLowerCase().replace(/\s+/g,'')
    
    name = $(this).val().toLowerCase().replace(/\s+/g,'')
    clidot = $('#proj-client-h').text().toLowerCase().replace(/\s+/g,'.')
    namedot = $(this).val().toLowerCase().replace(/\s+/g,'.')
    $('.relative-variant').append(
      '<p><span id="handle"><span>'+client+'.'+project+'.<span class="rel_name">'+name+'</span></span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
      '<p><span id="handle"><span>'+client+'_'+project+'_<span class="rel_name">'+name+'</span></span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
      '<p><span id="handle"><span>'+project+'_'+client+'_<span class="rel_name">'+name+'</span></span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'

    )
    
    
    
  $('.icon-ok').live 'click': ->
    value_rel = $(this).parent().children().eq(0).text()
    $('#application_relative_path').val(value_rel)
  
  
  
  
  
  
  
  
  
  
  