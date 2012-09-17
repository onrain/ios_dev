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
              $(this).next().append("<div><a href='/admin/applications/"+data[i].id+"'>"+data[i].product_name+"</a></div>")
              i+=1
            

    else if click is 1
      $('.append-projects').empty()
      click = 0
      
  