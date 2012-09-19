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
  
  $('.index-content').parent().append('<div id="store" style="display:none;"></div')
  
  
  
  $('.prev-app').live 'click': ->
    $('.index-content').empty()
    $('#app-title').empty()
    $('#app-list').modal('show':true)
    id = $(this).attr('id')
    $.get '/admin/applications?get=app&id='+id, (data) =>
      count = Object.keys(data).length
      $('#app-title').append('Application: '+data.product_name)
      $('.index-content').append('
        <table class="table table-bordered">
          <tr>
            <th>ID</th>
            <td class="show-and-edit-app" id="id">'+data.id+'</td>
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
        </table>
        ')
      
  
  
  
  $('.show-and-edit-app').live 'mousemove': ->
    if $(this).children().eq(1).attr('class') isnt 'icon-ok-sign save-app pull-right'
      $('.edit-app').remove()
      $(this).append('<i class="icon-edit edit-app pull-right" style="font-size:19px;"></i>')
    
  $('.show-and-edit-app').live 'mouseleave': ->
    $('.edit-app').remove()
  
  
   
  
  $('.edit-app').live 'click': ->
    flag = 1  
    
    len = $('.index-content').find('input').length
    
    
    this_el = $(this).parent().eq(0)
    this_id = this_el.attr('id')
    th = $(this).parent().parent().find('th').text()
    th_text = th.toLowerCase().replace(" ","_")
    
    if len > 0
      if confirm('Are you sure?')
        flag = 1
      else flag = 0

        
    if flag is 1
      
      $('#store').text(this_el.text())
  
  
  
  
  
      $('#store').after("<span id='el_id'>"+this_id+"</span>")
      this_el.empty()
      this_el.append('<input type="text" name="'+th_text+'" id="'+$('#store').children().eq(0).html()+'" value="'+$('#store').text()+'">')
  
      this_el.append('<i class="icon-ok-sign save-app pull-right" style="font-size:19px;" title="Save this?"></i>')

  
  
  
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
      
  