class DevelopersController < ApplicationController
  respond_to :json, :html, :xml
  helper_method :sort_column, :sort_direction
  
  def index
    @developers = Developer.get_dev_list.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    
    unless params[:developer_name].nil?

      unless params[:developer_name].blank?
        @developer = Developer.create(name:params[:developer_name])
        return render json: Developer.last
      else
        return render json: [error:'Can`t be blank!']
      end
    end

    respond_with(@developers)
  end


  def show
    @developer = Developer.get_dev_list_where_id(params[:id])

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
        format.html { redirect_to @developer, notice: 'Developer was successfully create.' }
        #format.json { render json: Developer.last, status: :created, location: @developer }
      else

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


private
  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  

end
