class ManagersController < ApplicationController
  respond_to :html, :json, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!
  caches_action :index, :layout => false, :gzip => :best_speed
  
  def index
    @managers = Manager.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    get_notice(params[:notice], 'Manager was successfully create.', 'Manager was successfully updated.')
    respond_with(@managers)
  end


  def show
    manager_id = params[:id]
    @projects = Project.where('manager_id = ?', manager_id)
    respond_with @manager = Manager.find(manager_id)
  end

  def new
    respond_with @manager = Manager.new
  end
  
  def edit
    @manager = Manager.find(params[:id])
  end


  def create
    @manager = Manager.new(params[:manager])

    respond_with(@manager) do |format|
      if @manager.save
        format.html { redirect_to managers_path+'?notice=created' }
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
        format.html { redirect_to managers_path+'?notice=updated' }
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
    redirect_to managers_url
  end

end
