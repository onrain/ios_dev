class ProjectsController < ApplicationController
  respond_to :json, :html, :xml
  
  def index
    client = Client.all
    @projects = Project.get_proj_list
    
    respond_with(@projects)
  end


  def show
    @project = Project.get_proj_list_where_id(params[:id])

    respond_with(@project)
  end


  def new
    @project = Project.new
    respond_with(@project)
  end


  def edit
    @project = Project.find(params[:id])
  end



  def create
    @project = Project.new(params[:project])

    respond_with(@project) do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
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
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
end
