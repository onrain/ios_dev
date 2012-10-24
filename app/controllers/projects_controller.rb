class ProjectsController < ApplicationController
  respond_to :json, :html, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!


  def index
    
    unless params[:method].blank? 
      method = params[:method]
      project_id = params[:proj_id]
      if method.eql? 'delete'
        delete_application_folder_relation Project.find(project_id).applications
        return render json: [status:"deleted"]
      
      elsif method.eql? 'move'
        move_application_f_list Project.find(project_id).applications 
        return render json: [status:'moved']
      end
    end
      
    return(render json: Project.find(params[:project_id])) unless params[:project_id].blank?

    @projects = Project.joins("left join managers on managers.id = projects.manager_id left join clients on clients.id = projects.client_id").select("projects.*, managers.name as manager_name, clients.name as client_name").page(params[:page]).per(10).order(sort_column(Project) + " " + sort_direction)

    get_notice(params[:notice], 'Project was successfully create.', 'Project was successfully updated.')
    
    return(render json: Project.find(params[:id]).applications) unless params[:application].blank?
  
    
    
    @new_app = Application.new

    respond_with(@projects)
  end


  def show 
    @application = Application.find_all_by_project_id(params[:id])
    @developers = Project.find(params[:id]).developers
    @new_app = Application.new
    respond_with @project = Project.joins("left join managers on managers.id = projects.manager_id left join clients on clients.id = projects.client_id").select("projects.*, managers.name as manager_name, clients.name as client_name").where("projects.id = ?",params[:id])
  end


  def new
    @developer = Developer.new
    @project = Project.new
  end


  def edit
    @project = Project.find(params[:id])
    @developer = Developer.new
  end



  def create
    @project = Project.new(params[:project])
    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to projects_path+'?notice=updated'}
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  


  def update
    params[:project][:developer_ids] ||= []
    @project = Project.find(params[:id])

    respond_with(@project) do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to projects_path+'?notice=created' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @project = Project.find(params[:id])
    @project.applications.delete_all unless @project.applications.size.eql? 0 
    @project.destroy
    redirect_to projects_url
  end
end
