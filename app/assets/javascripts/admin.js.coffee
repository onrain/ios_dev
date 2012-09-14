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
  
  
  
  
  $('#index-modal').modal(
          "backdrop" : "static",
          "keyboard" : true,
          'show' : false
          )
  

  
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
      
      
  
  
  $(".get-list-applications").click ->
    id = $(this).attr('id')
    if id isnt ''
      $('#index-modal').modal(show:true)
      $.get '/admin/applications?get=product&id='+id, (data) =>
        count = Object.keys(data).length
        $('.append-index-modal').empty()
        $('#index-title').empty()
        $('#index-title').append('Show applications list')
        i = 0
        while i < count
          $('.append-index-modal').append("<tr>
              <td><a href='/admin/applications/"+data[i].id+"'>"+data[i].product_name+"</a></td>
            </tr>")
          i+=1
          
          
  $(".get-list-developers").click ->
    id = $(this).attr('id')
    $.get '/admin/developers?get=product&id='+id, (data) =>
      count = Object.keys(data).length
      if count isnt 0
        $('#index-modal').modal(show:true)
        $('.append-index-modal').empty()
        $('#index-title').empty()
        $('#index-title').append('Show developers list')
        i = 0
        while i < count
          $('.append-index-modal').append("<tr>
              <td><a href='/admin/developers/"+data[i].id+"'>"+data[i].name+"</a></td>
            </tr>")
          i+=1
      else if count is 0
        $(this).attr('disabled':'disabled')

  