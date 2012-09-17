class AdminController < ApplicationController
  respond_to :json, :xml, :html
  helper_method :sort_column, :sort_direction

  def index  
    project_size = Project.all.size
    lim = params[:lim]
    lim = project_size if params[:lim].eql? 'all'
    @projects = Project
    .select('clients.name as client_name, managers.name as manager_name, applications.id as product_id,
    projects.*')
    .joins('left join applications on applications.project_id = projects.id
    left join clients on clients.id = projects.client_id
    left join managers on managers.id = projects.manager_id')
    .limit(lim).page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    
    respond_with(@projects)
  end

private
  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end

