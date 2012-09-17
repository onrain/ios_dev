class ApplicationsController < ApplicationController
  respond_to :json, :html, :xml
  helper_method :sort_column, :sort_direction

  
  def index
    
    unless params[:get].blank?
      @get_app_in_admin_index = Application.find_all_by_project_id(params[:id])
      return render json: @get_app_in_admin_index
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


  def create
    @application = Application.new(params[:application])

    respond_with(@application) do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render json: @application, status: :created, location: @application }
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
      format.json { head :no_content }
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
