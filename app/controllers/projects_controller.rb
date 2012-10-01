class ProjectsController < ApplicationController
  respond_to :json, :html, :xml
  helper_method :sort_column, :sort_direction

  def index

    unless params[:p].blank?
      return render json: Project.find(params[:p])
    end

    @projects = Project.get_proj_list.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    flash[:notice] = nil
    unless params[:n].blank?
      case(params[:n])
        when 'updated' then flash[:notice] = 'Project was successfully updated.'
        when 'created' then flash[:notice] = 'Project was successfully created.'
        else return nil 
      end
    end

    @new_app = Application.new

    respond_with(@projects)
  end


  def show
    @project = Project.get_proj_list_where_id(params[:id])
    @application = Application.find_all_by_project_id(params[:id])
    @new_app = Application.new
    respond_with(@project)
  end


  def new
    @project = Project.new
    @developer = Developer.new
    respond_with(@project)
  end


  def edit
    @project = Project.find(params[:id])
    @developer = Developer.new
  end



  def create
    @project = Project.new(params[:project])
    puts params[:project][:developer_ids]
    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to projects_path+'?n=updated'}
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
        format.html { redirect_to projects_path+'?n=created' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_with(@project) do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end


private
  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end




end
