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
      <table class="table table_no_bordered">
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
              <a class="edit-link btn btn-small" id="'+data.id+'">Edit</a>
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
            <td colspan="5">
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
            <table width="100%">
              <tr>
                <td colspan="5" style="background-color: rgba(204,204,204, 0.3);">
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
   
        $('.edit-link').live 'click': ->
          id = $(this).attr('id')
          $('#app-list').modal('show':true)
          $.get '/admin/applications?get=app&id='+id, (data) =>
                               
            $('#app-title').empty()
            $('#app-title').append('Application: '+data.product_name)
            $('.index-content').empty()
            $('.index-content').append('
             <form accept-charset="UTF-8" action="/admin/remote_update/'+id+'" data-remote="true" class="edit_application" id="edit_application_'+id+'" method="post">
              <table class="table table-bordered table-app">
                  <tr>
                    <th>Project ID</th>
                    <td class="show-and-edit-app" id="id">
                      <select name="application[project_id]" id="application_project_name">
                        
                      </select>
                   
                    
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
        
        
        $('#tr_delete_').live 'click': ->
          $(this).parent().parent().parent().remove()
        
        $('#duplicate').live 'click': ->
          $('a[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
            document.location.reload(true)
  $('.add_new').live 'click': ->
    id = $(this).attr('id')
    parent_el = $(this).parent().parent().parent().parent()

    if parent_el.children().eq(1).length isnt 0
      parent_el.children().eq(1).remove()

    else
      parent_el.append(
        '<table style="margin: 0 auto; width:100%;" class="table table-bordered open-new-app">
          <tr>
            <td id="append_'+id+'">
            </td>
          </tr>
        </table>'            
      )
      
      $('#append_'+id).append($('#proj_'+id).html())
            
 
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
      
        
    
    $('.error_proj').click ->
      $(this).val('')
      $(this).removeClass('error_proj')
        
  $('.notice-admin').mousemove ->
    $(this).empty()