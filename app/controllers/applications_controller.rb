class ApplicationsController < ApplicationController
  respond_to :json, :html, :xml
  helper_method :sort_column, :sort_direction

  
  def index
    
    unless params[:get].blank?
      @get_app_in_admin_index = Application.find_all_by_project_id(params[:id])
      @get_app_in_admin_index = Application.find(params[:id]) if params[:get].eql? 'app'
      return render json: @get_app_in_admin_index
    end

    unless params[:ch].blank?
      @check = Application.find_all_by_bundle_identifier(params[:val])
      return render json: @check
    end


    @applications = Application.get_app_list.page(params[:page]).per(10).order("#{sort_column} #{sort_direction}")
    respond_with(@applications)
  end

  def show
    @application = Application.get_app_list_where_id(params[:id])  
    

    respond_with(@application)
  end


  def new
    @application = Application.new

    respond_with(@application)
  end


  def edit
    @application = Application.find(params[:id])
  end

  def remote_update
    @application = Application.find(params[:id])

    respond_with(@application) do |format|
      if @application.update_attributes(params[:application])
        format.json { render json: Application.find(params[:id]) }
      else
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @application = Application.new(params[:application])

    respond_with(@application) do |format|
      if @application.save
        proj_id = params[:application][:project_id]
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render json: Application.where(project_id:proj_id), status: :created, location: @application }
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @application = Application.find(params[:id])

    respond_with(@application) do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_with(@application) do |format|
      format.html { redirect_to applications_url }
      format.json { render json: [status:'deleted'] }

    end
  end

private
  def sort_column
    Application.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
