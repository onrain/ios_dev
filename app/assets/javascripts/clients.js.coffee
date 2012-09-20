$ ->
    
  class Client
    constructor: ->
      @init()
      @company()
      @handle_name()
   
    init: ->
      $('#new-company').modal(
          "backdrop" : "static",
          "keyboard" : true,
          'show' : false
          )
      
        
        
      $('#get-new-company').click ->
        $('#new-company').modal(show:true)
        $('#cname').val('')
        $('#cwebsite').val('')
        $('.form-notice').empty()
        
   
   
   
      
        
            

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
      
    handle_name: ->  
      $('#client_name').bind 'input': ->
        $('.handle-variant').empty()
        company = $('#client_company_id :selected').text().toLowerCase().replace(/\s+/g,'')
        name = $(this).val().toLowerCase().replace(/\s+/g,'')
        comdot = $('#client_company_id :selected').text().toLowerCase().replace(/\s+/g,'.')
        namedot = $(this).val().toLowerCase().replace(/\s+/g,'.')
        $('.handle-variant').append(
          '<p><span id="handle"><span>'+name+'.<span class="comp_name">'+company+'</span></span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
          '<p><span id="handle"><span class="comp_name">'+company+'</span>.'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
          '<p><span id="handle"><span class="comp_name">'+company+'</span>'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
          '<p><span id="handle"><span class="comp_name">'+comdot+'</span>'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
          '<p><span id="handle"><span class="comp_name">'+company+'</span>_'+namedot+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
          '<p><span id="handle"><span class="comp_name">'+company+'</span>_'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span>'
          '<p><span id="handle"><span class="comp_name">'+company.substring(0,3)+'</span>'+name+'</span>&nbsp;&nbsp;<span class="icon-ok"></span></p>'
        )
        
      $('#client_company_id option').click ->
        company = $(this).text().toLowerCase().replace(/\s+/g,'')
        $('.comp_name').empty()
        $('.comp_name').text(company)
        
      $('.icon-ok').live 'click': ->
        value_h = $(this).parent().children().eq(0).text()
        $('#client_handle').val(value_h)

  new Client

  
  
  
    