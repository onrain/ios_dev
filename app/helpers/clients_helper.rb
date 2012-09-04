module ClientsHelper
  def check_company(name, id)
    if name.nil?
      name = "<div style='color:gray; font-size:15px;'>Empty.</div>" 
    else
      name = "<a href="+company_path(id)+">"+name+"</a>"
    end
    name
  end
end
