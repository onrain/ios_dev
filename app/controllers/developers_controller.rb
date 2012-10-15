class DevelopersController < ApplicationController
  respond_to :json, :html, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!

  
  def index
    @developers = Developer.get_dev_list.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    
    get_notice(params[:notice], 'Developer was successfully create.', 'Developer was successfully updated.')

    id = params[:manager_id]
    return(render json: Developer.where("manager_id = ?",id)) unless params[:manager_id].blank?
    respond_with(@developers)
  end


  def show
    respond_with @developer = Developer.find(params[:id]).manager.select('name as manager_name')
  end

  def new
    respond_with @developer = Developer.new
  end


  def edit
    @developer = Developer.find(params[:id])
  end


  def create
    
    @developer = Developer.new(params[:developer])
    respond_with(@developer) do |format|
      if @developer.save
        format.html { redirect_to developers_path+'?notice=created' }
      else
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @developer = Developer.find(params[:id])

    respond_with(@developer) do |format|
      if @developer.update_attributes(params[:developer])
        format.html { redirect_to developers_path+'?notice=updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @developer = Developer.find(params[:id])
    @developer.destroy

    redirect_to developers_url
  end 
end
