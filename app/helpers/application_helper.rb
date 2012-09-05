module ApplicationHelper

  def check_path(name, id, path = Hash.new)
    id = id.to_s
    if name.nil?
      name = "<div style='color:gray; font-size:15px;'>Empty.</div>" 
    else
      name = "<a href=/admin/"+path[:path]+"/"+id+">"+name+"</a>"
    end
    name
  end

  def back(path)
    if request.env['HTTP_REFERER'] =~ /admin/
      res = request.env['HTTP_REFERER']
	  else
      path
    end
  end

end
