module ClientsHelper
  def check_company(name)
    name = "<div style='color:gray; font-size:15px;'>Empty.</div>" if name.nil?
    name
  end
end
