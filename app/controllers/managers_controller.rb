class ManagersController < ApplicationController
  respond_to :html, :json, :xml
  def index
    @managers = Manager.all
    respond_with(@managers)
  end


  def show
    @manager = Manager.find(params[:id])
    respond_with(@manager)
  end

  def new
    @manager = Manager.new
    respond_with(@manager)
  end
  
  def edit
    @manager = Manager.find(params[:id])
  end


  def create
    @manager = Manager.new(params[:manager])

    respond_with(@manager) do |format|
      if @manager.save
        format.html { redirect_to @manager, notice: 'Manager was successfully created.' }
        format.json { render json: @manager, status: :created, location: @manager }
      else
        format.html { render action: "new" }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @manager = Manager.find(params[:id])

    respond_with(@manager) do |format|
      if @manager.update_attributes(params[:manager])
        format.html { redirect_to @manager, notice: 'Manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_with(@manager) do |format|
      format.html { redirect_to managers_url }
      format.json { head :no_content }
    end
  end
end
