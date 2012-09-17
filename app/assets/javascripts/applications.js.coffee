$ ->
  $('#application_project_id option').click ->
    $.get '/admin/projects/'+$(this).attr('value'), (data) =>
      $('.store').empty()
      $('.store').text(data[0].handle)
      #alert data[0].handle
  $('#application_product_name').bind 'input': ->
    $('#application_relative_path').val($('.store').text()+"/"+$(this).val().toLowerCase())
