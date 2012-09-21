$ ->
  path = window.location.pathname

  if (/clients/).test(path)
    $('#clients-nav').addClass('active')
  if (/admin\/companies/).test(path)
    $('#company-nav').addClass('active')
  if (/admin\/managers/).test(path)
    $('#manager-nav').addClass('active')
  if (/admin\/developers/).test(path)
    $('#developers-nav').addClass('active')
  if (/admin\/projects/).test(path)
    $('#projects-nav').addClass('active')
  if (/admin\/applications/).test(path)
    $('#app-nav').addClass('active')
  
   $('.field_with_errors').click ->
    $(this).removeClass('field_with_errors')
  
  
  
  
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
      
      
  
  click = 0

  $(".get-list-applications").click ->
    
    if $(this).attr('class').match(/icon-chevron-up/)
      parent_id = $(this).parent().parent().attr('id')
      _pos = parent_id.indexOf('_')
      parent = parent_id.substring(_pos+1, parent_id.length)
      $('#tr_'+parent).remove()
      $(this).toggleClass('icon-chevron-up')
    else  
      $(this).toggleClass('icon-chevron-up')
  
      id = $(this).attr('id')
      if id isnt ''
        $.get '/admin/applications?get=product&id='+id, (data) =>
          count = Object.keys(data).length
          i = 0
          $(this).parent().parent().eq(0).after('
           <tr id="tr_'+id+'">
             
           </tr>
            ')
          while i < count 
            $('#tr_'+id).append(
              '
                <td colspan="5">
                  <a id="'+data[i].id+'" class="prev-app">'+data[i].product_name+'</a></td>
                 <td style="height:20px">
                    <div class="app-panel">
                      <span class="icon-pencil"></span>&nbsp;<span class="icon-eye-open"></span>&nbsp;<span class="icon-trash"></span>
                    </div>
              </td>'

              
              
              
            )
            if i+1 isnt count
              $(this).next().append(", ")
            i+=1
  