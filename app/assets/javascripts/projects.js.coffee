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
      $('#show-dev').click()
    $('#reload').live 'mousemove': ->
      $(this).css('cursor':'pointer')
    $('.dev-notice').mousemove ->
      $(this).empty()