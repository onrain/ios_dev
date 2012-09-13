$ ->
  $('#dev-list').modal(
    "backdrop" : "static",
    "keyboard" : true,
    'show' : false
    )
	
  $('#show-dev').click ->
    $('#dev-list').modal(show:true)
    $('#dev-input').val('')
  $('input[type="checkbox"]:checked + span').each ->
    $('.select-dev-list').append("[ "+$(this).text()+" ]")
    
  $('#add-dev-btn').click ->
    $('.select-dev-list').empty()
    $('input[type="checkbox"]:checked + span').each ->
      $('.select-dev-list').append("[ "+$(this).text()+" ]")
      
      
      
      
  $('#dev-input').bind 'input': ->
    $('#dev-link-remote').attr('href', "/admin/developers/?developer_name="+$(this).val())
  
  
  $('#dev-link-remote').click ->
      $('.handle-notice').empty()
    $('a[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
      $('.handle-notice').empty()
      errors = $.parseJSON(data.responseText)
      if status is 'error'
        $('.dev-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Handle name '+errors.name+'</span>')

      
    $('a[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
      $('.handle-notice').empty()
      $('.dev-notice').empty()
      $('.searchable').append("<p><input type='checkbox' id='project_developer_ids_' disabled='disabled' name='project[developer_ids][]' value='"+data.id+"' /><span>"+data.name+"</span>&nbsp;<span class='icon-exclamation-sign' style='color:red;'></span></p>")     
      $('.dev-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Developer was success create!</span>')
      $('.dev-reload-notice').empty()
      $('.dev-reload-notice').html("<a id='reload'>For apply changes please reload page!</a>")
    
    $('#reload').live 'click': ->
      window.location.reload()
      #$('#show-dev').click()
    $('#reload').live 'mousemove': ->
      $(this).css('cursor':'pointer')
    $('.dev-notice').mousemove ->
      $(this).empty()
  
  
  
  
      
  $('#project_name').bind 'input': ->    
          
    $('.pn').text($(this).val())
  
  
  $('.change_handle').append('<i class="icon-plus-sign" id="proj-pop" style="position:absolute; margin-left:5px; margin-top:6px;"><i/>')
  
  
  

  $('#proj-pop').live 'click': ->

    $(this).popover(
      content: ->
        $(this).parent().next().html()
      placement: 'bottom'
    )
    
    
    
  
  $('#proj-pop').live 'click': ->
    
    if $('#proj-h-variants').text().length == 0
      id = $('#project_client_id option:selected').val()
      pn = $('#project_name').val()
      get_and_push_handle(id, pn)
  
  
     
  $('#project_client_id option').click ->
    id = $(this).val()
    pn = $('#project_name').val()
    get_and_push_handle(id, pn)
  
  get_and_push_handle = (id, pn) ->
    $.get "/admin/clients?get=handle&handle_id="+id, (data) =>
      
      $('#proj-h-variants').empty()
      
      count = Object.keys(data).length
      if count is 0
        return $('#proj-h-variants').append('<p>Empty.</p>')
      
      i=0
      proj_name = $('#project_name').val()
      while i < count
        $('#proj-h-variants').append('<p style="border: 1px solid gray;"><a style="cursor:pointer;">'+data[i].handle_name+'<span class="pn">'+pn+'</span>'+'</a><br />')
        $('#proj-h-variants').append('<a style="cursor:pointer;">'+data[i].handle_name+'_<span class="pn">'+pn+'</span></a><br />')
        $('#proj-h-variants').append('<a style="cursor:pointer;">'+data[i].handle_name+'.<span class="pn">'+pn+'</span></a></p>')
        i+=1

      return 0;