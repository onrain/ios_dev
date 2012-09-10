$ ->
  
  company = $('#client_company_id').change ->
    company = $(':selected').text()
    if company?
      return company = company+"/"
    else
      return null

  

  $('#client_name').bind 'input': ->
    if company? and company isnt 'None'
      company = company
    $('.handle-variant').children().remove()
    name = $(this).val().replace(/(&nbsp;)+|\s+/g, '')
    $('.handle-variant').append("<div id='hh'>"+"<span id='hc'>"+company+"</span>"+"<span id='hn'>"+name+"</span>"+"<span id='add'></span>"+"</div>")
    $('.handle-variant #add').addClass('icon-plus-sign').live('mousemove', -> $(this).css('cursor':'pointer'))
    $('#add').click ->
      handle = $(this).parent().text().replace(/(&nbsp;)+|\s+/g, '')
      $('#client_handle').val(handle)
      $(this).parent().remove()
      $(this).remove()
  