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


  append_html = (data) ->
    $('.clients-content').empty()
    insert_text = '
      <table class="table table-bordered table-app">
        <div class="notice-client"></div>
        <tr>
          <th>ID</th>
          <td>'+data.id+'</td>
        </tr>     
        <tr>
          <th>Client name</th>
          <td class="show-and-edit-app" id="client_name">'+data.name+'</td>
        </tr>
        <tr>
          <th>Email</th>
          <td class="show-and-edit-app" id="client_email">'+data.email+'</td>
        </tr>
        <tr>
          <th>Handle</th>
          <td class="show-and-edit-app" id="client_handle">'+data.handle+'</td>
        </tr>
        <tr>
          <th>Action</th>
          <td>
            <a id="edit_'+data.id+'"class="btn btn-small">Edit</a>
            &nbsp;
            <a rel="nofollow" data-method="delete" data-remote="true" class="btn btn-small" data-confirm="Are you sure?" id="delete_'+data.id+'" href="/admin/clients/'+data.id+'">Destroy</a>
          </td>
        </tr>
      </table>'

  $('.prev-client').live 'click': ->
    $('.notice-app').empty()
    $('.clients-content').empty()
    $('#client-title').empty()
    $('#client-list').modal('show':true)
    id = $(this).attr('id')
    $.get '/admin/clients?get=cl&id='+id, (data) =>
      $('#client-title').append('Client: '+data.name)
      $('.clients-content').empty()
      $('.clients-content').append(append_html(data))
    $('#delete_'+id).live 'click': ->
      location.reload(true)


    $('#edit_'+id).live 'click': ->

      $.get '/admin/clients?get=cl&id='+id, (data) =>
        $('.clients-content').empty()
        $('.clients-content').append('
         <form accept-charset="UTF-8" action="/admin/client_remote_update/'+id+'" data-remote="true" class="edit_client" id="edit_client_'+id+'" method="post">
          <table class="table table-bordered table-app">
              <tr>
                <th>Company ID</th>
                <td class="show-and-edit-client" id="id"><input id="client_company_id" name="client[company_id]" size="30" type="text" value="'+data.company_id+'" /></td>
              </tr>
              <tr>
                <th>Name</th>
                <td class="show-and-edit-client" id="client_name"><input id="client_name" name="client[name]" size="30" type="text" value="'+data.name+'" /></td>
              </tr>
              <tr>
                <th>Email</th>
                <td class="show-and-edit-client" id="email"> <input id="client_email" name="client[email]" size="30" type="text" value="'+data.email+'" /></td>
              </tr>
              <tr>
                <th>Handle name</th>
                <td class="show-and-edit-client" id="handle"> <input id="client_handle" name="client[handle]" size="30" type="text" value="'+data.handle+'" />
                <div class="handle-variant"></div>
                </td>
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
        $('.clients-content').empty()
        $('.clients-content').append(append_html(data))
        $('.notice-client').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Cleint was success update!</span>')    
        $('.notice-client').mousemove ->
          $(this).empty()

      $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
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
      

      
      
    $('div[id*="handle"]').live 'click': ->
      
      company = $('#company_name').text().toLowerCase().replace(/\s+/g,'')
        
      $('#client_handle').val(company+'/'+$(this).text().replace(/\s+/g,''))




