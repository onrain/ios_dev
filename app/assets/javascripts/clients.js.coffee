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
          $('#client_company_id').append('<option value='+data.id+' selected="selected">'+data.name+'</option>')
          
          $('.form-notice').append('<span class="icon-ok" style="color:green;"></span>&nbsp;<span style="color:green;" id="success-append">Company was success create!</span>')
          $('.form-notice').mousemove ->
            $(this).empty()
      
    handle_name: ->  
      $('#client_name').bind 'input': ->
        $('.handle-variant').empty()
        company = $('#client_company_id :selected').text().toLowerCase().replace(/\s+/g,'')

        name = $(this).val().toLowerCase()
        comdot = $('#client_company_id :selected').text().toLowerCase().replace(/\s+/g,'.')
        namedot = $(this).val().toLowerCase().replace(/\s+/g,'.')
        res = name.split(" ")
        j = 1
        i = 0
        variant = 4
        count = 0
        while count < variant
          $('.handle-variant').append("<div class='variant"+count+"'></div>")
          count++
        while i < res.length
          k = 0
          $('.variant0').append('<div id="handle'+i+'"></div>')
          $('.variant1').append('<div id="handle'+i+'"></div>')
          $('.variant2').append('<div id="handle'+i+'"></div>')
          $('.variant3').append('<div id="handle'+i+'"></div>')
          while k < j
            $('.variant0 #handle'+i).append(res[k])
            if k+1 < j
              $('.variant1 #handle'+i).append(res[k]+".")
            else if k>0
              $('.variant1 #handle'+i).append(res[k])
            if k+1 < j
              $('.variant2 #handle'+i).append(res[k]+"-")
            else if k>0
              $('.variant2 #handle'+i).append(res[k])
            if k+1 < j
              $('.variant3 #handle'+i).append(res[k]+"_")
            else if k>0
              $('.variant3 #handle'+i).append(res[k])
            k++    
          j++
          i++
        

        
      $('#client_company_id option').click ->
        company = $(this).text().toLowerCase().replace(/\s+/g,'')
        
        if company is 'none'
          return false
        $('.comp_name').empty()
        $('.comp_name').text(company)
        
      $('.icon-ok').live 'click': ->
        value_h = $(this).parent().children().eq(0).text()
        $('#client_handle').val(value_h)
      
       
        
        
        
        

  new Client

  
  
  
    