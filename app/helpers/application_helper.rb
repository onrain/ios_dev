module ApplicationHelper

  def check_path(name, id, path = Hash.new)
    id = id.to_s
    if name.nil?
      name = "<div style='color:gray; font-size:13px;'>empty</div>" 
    else
      name = "<a href='/admin/#{path[:path]}/#{id}'>"+name+"</a>"
    end
    name
  end
  
  def check_f(param)
    if param.nil? or param.empty?
      param ="<div style='color:gray; font-size:13px;'>empty</div>".html_safe
    else
      param
    end
  end




  def back(path)
    if request.env['HTTP_REFERER'] =~ /admin/
      res = request.env['HTTP_REFERER']
	  else
      path
    end
  end


  def set_time(current_time)
    return "" if current_time.nil?
    current_time.strftime('%B %d, %Y at %H:%M')
  end

end
