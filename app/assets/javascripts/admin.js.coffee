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
  
  
  $('.sort').css('color':'black')
  $('.sort').mousemove ->
    $(this).css('text-decoration':'none')

    
  fullpath = document.location.href
  
  ####################################
  isa = fullpath.indexOf('=')
  amp = fullpath.indexOf('&')
  type = fullpath.substring(isa+1, amp)
  ####################################
  
  sort = fullpath.lastIndexOf('=')
  sort = fullpath.substring(sort+1, fullpath.length)
  
  switch type
    when 'asc' 
      $('#'+sort).addClass('icon-chevron-up')
      $('#'+sort).parent().addClass('select-th')
    when 'desc' 
      $('#'+sort).addClass('icon-chevron-down')
      $('#'+sort).parent().addClass('select-th')
   
  