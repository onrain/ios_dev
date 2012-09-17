$ ->
  $('#application_project_id option').click ->
    if $(this).text() isnt 'None'
      $.get '/admin/projects/'+$(this).attr('value'), (data) =>
        if data[0].handle is ''
          $('#goto-edit-project').remove()
          $('#application_project_id').after('<div id="goto-edit-project">Project handled name is empty. &nbsp; <a href="/admin/projects/'+$(this).val()+'/edit" target="blank">Edit project</a></div>')
        $('.store').empty()
        $('.store').text(data[0].handle)

  $('#application_product_name').bind 'input': ->
    $('#application_relative_path').val($('.store').text()+"/"+$(this).val().toLowerCase())
