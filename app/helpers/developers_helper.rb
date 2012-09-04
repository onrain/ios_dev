module DevelopersHelper
  def check_manager(name, id)
    if name.nil?
      name = "<div style='color:gray; font-size:15px;'>Empty.</div>" 
    else
      name = "<a href="+manager_path(id)+">"+name+"</a>"
    end
    name
  end
end
