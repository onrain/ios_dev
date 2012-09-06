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