$ ->

  if $('#developer_manager_id option').length > 1
    $('#developer_manager_id').children().eq(1).attr('selected', 'selected')





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

  

