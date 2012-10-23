class AdminController < ApplicationController
  respond_to :json, :xml, :html
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!

  def index  

    @projects = Project
    .select('clients.name as client_name, managers.name as manager_name,
    projects.*')
    .joins('left join clients on clients.id = projects.client_id
    left join managers on managers.id = projects.manager_id')
    .group('projects.id, clients.name, managers.name')
    .page(params[:page]).per(10).order(sort_column(Project) + " " + sort_direction)
    @new_app = Application.new
    respond_with(@projects)
  end
end

