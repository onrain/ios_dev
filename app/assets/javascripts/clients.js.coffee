$ ->
    
  class Client
    constructor: ->
      @init()
      @company()
      @handle()
      @index_h_list()
  
    init: ->
      $('#new-company').modal(
          "backdrop" : "static",
          "keyboard" : true,
          'show' : false
          )
      
      $('#handle-name').modal(
          "backdrop" : "static",
          "keyboard" : true,
          'show' : false
          )
        
      $('#get-handles').click ->
        $('#handle-name').modal(show:true)
        $('.handle-notice').empty()
        
      $('.get-handles').click ->
        $('#handle-name').modal(show:true)
        $('.handle-notice').empty()
        
        
      $('#get-new-company').click ->
        $('#new-company').modal(show:true)
        $('#cname').val('')
        $('#cwebsite').val('')
        $('.form-notice').empty()
        
   
   
   
        
        
    index_h_list: ->
      $('.get-handles').click ->
        $(".popover").hide()
        $(this).removeClass('colored')
        $('a[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->        
          $('#append-index-handle').empty()  
          count = Object.keys(data).length
          i = 0
          while i < count
            $('#append-index-handle').append("<tr><td><a href='/admin/clients/"+(data[i].client_id)+"'>"+data[i].handle_name+"</td></tr>")
            i += 1

      
        
      
      $('.popover-inner').children().eq(0).empty()

      $('.add-or-get-h').click ->
        
        $('.notice-index').empty()
        $(this).popover({
          content: getPopContent($(this))
        })
      
      
        
      getPopContent = (el) ->
        return el.next().html()
    
    
    
      $('#add-index-h').live 'click': ->
        id = $(this).attr('title')
        
        $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
          $('#'+id).addClass('colored')
          #$('.add-or-get-h').popover('hide')
          $('.notice-index').empty()
          $('.notice-index').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Handle was success create!</span>')    
          $('#append-index-handle').empty()     
          count = Object.keys(data).length
          i = 0
          while i < count
            $('#append-index-handle').append("<tr><td><a href='/admin/clients/"+(data[i].client_id)+"'>"+data[i].handle_name+"</td></tr>")
            i += 1
            
            
        $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
          $('.notice-index').empty()
          errors = $.parseJSON(data.responseText)
          $('.notice-index').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Handle '+errors.handle_name+'</span>')


      $('.notice-index').live 'mousemove': ->
        $(this).empty()
            

    company: ->
      
      $('#new-com').click ->
         $('.form-notice').empty()
         
         $('#new-company form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
          $('.form-notice').empty()
          errors = $.parseJSON(data.responseText)
          $('.form-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Title '+errors.name+'</span>')
          $('.form-notice').mousemove ->
            $(this).empty()
        
        $('#new-company form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
          $('.form-notice').empty()
          $('#client_company_id').append('<option value'+data.id+' selected="selected">'+data.name+'</option>')
          
          $('.form-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Company was success create!</span>')
          $('.form-notice').mousemove ->
            $(this).empty()
      
    handle: ->  
      
      $('#new-handle').click ->
        $('.handle-notice').empty()
        
        $('form[data-remote]').bind "ajax:error", (event, data, status, xhr) ->
          $('.handle-notice').empty()
          errors = $.parseJSON(data.responseText)
          if status is 'error'
            $('.handle-notice').append('<span class="icon-remove" style="color:red;"></span>&nbsp;<span id="error-append" style="color:red;">Handle name '+errors.handle_name+'</span>')
          $('.handle-notice').mousemove ->
            $(this).empty()
            
            
        $('form[data-remote]').bind "ajax:success", (evt, data, status, xhr) ->
          $('.handle-notice').empty()
          $('#table-show-handle').empty()
          count = Object.keys(data).length
          i=0
          while i<count
            $('#table-show-handle').append("<tr id='tr_"+data[i].id+"'><td>"+data[i].handle_name+"<a href='/admin/remove/"+data[i].id+"' data-method='delete' class='rem_link' id='"+data[i].id+"' data-remote='true' data-confirm='Are you sure?' ><i class='icon-remove pull-right' style='color:red;'></i></a></td></tr>")
            i+=1
          $('.handle-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Handle was success create!</span>')
          $('.handle-notice').mousemove ->
            $(this).empty()
      
      
      $('#text-f-handle').bind 'input': ->
        $('#text-f-handle').val($(this).val().toLowerCase().replace(" ",".").replace(",","."))
      
      
      $('.rem_link').live 'click': ->
        $('.handle-notice').empty()
        l = $('#table-show-handle tr').length
        id = $(this).attr('id')
        if l is 1
          $('#tr_'+id).parent().remove()
        else
          $('#tr_'+id).remove()
        $('.handle-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Deleted success!</span>')
        $('.handle-notice').mousemove ->
          $(this).empty()
      

  new Client

  
  
  
    