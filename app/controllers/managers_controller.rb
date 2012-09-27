class ManagersController < ApplicationController
  respond_to :html, :json, :xml
  helper_method :sort_column, :sort_direction
  
  def index
    @managers = Manager.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    flash[:notice] = nil

    unless params[:n].blank?
      case(params[:n])
        when 'updated' then flash[:notice] = 'Manager was successfully updated.'
        when 'created' then flash[:notice] = 'Manager was successfully create.'
        else return nil 
      end
    end

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
        format.html { redirect_to managers_path+'?n=craeted' }
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
        format.html { redirect_to managers_path+'?n=updated' }
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


private
  def sort_column
    Manager.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  




end
