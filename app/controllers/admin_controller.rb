class AdminController < ApplicationController
  def index
   
   # details list on admin index page
   # Tree =>
   # - Projects last 10
   #   - Application of this proj(last 10) 
   # - Client
   # - Manager
   # - Developers 
   # DateS

   
    @projects = Project.find_by_sql(
    "select clients.name as client_name, managers.name as manager_name, applications.id as product_id,
    projects.*
    from projects
    left join applications on applications.project_id = projects.id
    left join clients on clients.id = projects.client_id
    left join managers on managers.id = projects.manager_id
    " 
    )




  end
end
