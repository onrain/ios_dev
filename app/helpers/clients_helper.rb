module ClientsHelper


  def get_h_all(res)

    unless res.nil?
      res =JSON.parse(res)
      s = res.size
      i = 0
      while i < s do
        obj = "<table class='table'>"
        obj += "<tr><td>#{res[i]['id']}</td>"
        obj += "<td><a href='#{client_path(res[i]['client_id'])}'>#{res[i]['handle_name']}</a></td></tr>" 
        obj += "</table>"
        i+=1
      end
    end
    obj
  end



end