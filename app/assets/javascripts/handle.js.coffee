$ ->
  
  company  = $('#client_company_id :selected').text()
   

  if typeof(company) is 'object' or typeof(company) is 'string' or company is 'None'
    company = $('#client_company_id').change ->
      company = $('#client_company_id :selected').text()

      if company?
        return company = company
      else
        return null
  space = 0
  $('#client_name').keydown (e) ->
    e = window.event || e
    e = e.keyCode
    if e isnt 32
      space = 0
    if e is 32
      space +=1
      if space > 1
        return false


  $('#client_name').bind 'input': ->
    
    $(this).val($(this).val().toLowerCase().replace(" ",".").replace(",","."));


    if typeof(company) isnt 'object' and company isnt 'None'
      $('.handle-variant').children().remove()
      name = $(this).val().replace(/(&nbsp;)+|\s+/g, '')
      $('.handle-variant').append("<div id='hh'>"+"<span id='hc'>"+company+"</span>"+"<span id='type'>/</span>"+"<span id='hn'>"+name+"</span>"+"<span class='add'></span>"+"</div>")
  
  
      $('.handle-variant').append("<div id='hh'>"+"<span id='hc'>"+company+"</span>"+"<span id='type'>.</span>"+"<span id='hn'>"+name+"</span>"+"<span class='add'></span>"+"</div>")
  
  
      $('.handle-variant .add').addClass('icon-plus-sign').live('mousemove', -> $(this).css('cursor':'pointer'))
      
      set_handle = (e) ->
        par = e.parent()
        handle = par.children().eq(0).text().replace(/(&nbsp;)+|\s+/g, '').toLowerCase()
        handle += par.children().eq(1).text().replace(/(&nbsp;)+|\s+/g, '')
        handle += par.children().eq(2).text().replace(/(&nbsp;)+|\s+/g, '').toLowerCase()
        
        $('#client_handle').val(handle)
  
  
      $('.add').click ->
        set_handle($(this))
    

  