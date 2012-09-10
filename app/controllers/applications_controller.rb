class ApplicationsController < ApplicationController
  respond_to :json, :html, :xml
  
  
  def index
    @applications = Application.get_app_list
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
end
