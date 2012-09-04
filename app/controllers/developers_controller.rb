class DevelopersController < ApplicationController
  respond_to :html, :json, :xml
  
  
  def index
    @developers = Developer.find_by_sql(
     "SELECT managers.name as manager_name, developers.* FROM developers
      LEFT JOIN managers ON managers.id = developers.manager_id")
    

    respond_with(@developers)
  end


  def show
    @developer = Developer.find(params[:id])

    respond_with(@developer)
  end

  def new
    @developer = Developer.new

    respond_with(@developer)
  end


  def edit
    @developer = Developer.find(params[:id])
  end


  def create
    @developer = Developer.new(params[:developer])

    respond_with(@developer) do |format|
      if @developer.save
        format.html { redirect_to @developer, notice: 'Developer was successfully created.' }
        format.json { render json: @developer, status: :created, location: @developer }
      else
        format.html { render action: "new" }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @developer = Developer.find(params[:id])

    respond_with(@developer) do |format|
      if @developer.update_attributes(params[:developer])
        format.html { redirect_to @developer, notice: 'Developer was successfully updated.' }
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

    respond_with(@destroy) do |format|
      format.html { redirect_to developers_url }
      format.json { head :no_content }
    end
  end
end
