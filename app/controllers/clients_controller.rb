class ClientsController < ApplicationController
  respond_to :json, :html, :xml
  helper_method :sort_column, :sort_direction

  def index
    flash[:notice] = nil

    unless params[:n].blank?
      case(params[:n])
        when 'updated' then flash[:notice] = 'Developer was successfully updated.'
        when 'created' then flash[:notice] = 'Developer was successfully create.'
        else return nil 
      end
    end

    unless params[:handle].blank?
      @client_handle = Client.find(params[:handle])
      return render json: @client_handle
    end
    unless params[:get].blank?
      @all_clients_for_company = Client.find(params[:id])
      return render json: @all_clients_for_company
    end
    
    @clients = Client.get_clients_list.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    @handle = Handle.new
    
    
    respond_with(@clients)
  end


  def show
    @client = Client.get_clients_list_where_id(params[:id])
    respond_with(@client)
  end


  def new
    @client = Client.new
    @company = Company.new
    respond_with(@client)
  end

  
  def handle


    @client = Client.find(params[:id])
    @handle = @client.handles.create(params[:handle])
         
       
       respond_with(@handle) do |format|
         if @handle.save
           format.json { render json: Handle.find_all_by_client_id(params[:id]), status: :created, location: @client }
         else
           #format.html { render action: "new" }
           format.json { render json: @handle.errors, status: :unprocessable_entity }
         end
       end

  end

  def remove
    @handle = Handle.find(params[:id])
    if @handle.destroy
      render json: [status:'deleted']
    end
  end
  
  def edit
    @company = Company.new
    @handle = Handle.new
    @client = Client.find(params[:id])
  end


  def create
    @client = Client.new(params[:client])
    @company = Company.new
   
    respond_with(@client) do |format|
      if @client.save
        format.html { redirect_to clients_path, notice:'Developer was successfully create.' }
        format.json { render json: Client.where(company_id:params[:client][:company_id]) }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end


  def remote_update
    @client = Client.find(params[:id])

    respond_with(@client) do |format|
      if @client.update_attributes(params[:client])
        format.json { render json: Client.find(params[:id]) }
      else
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @client = Client.find(params[:id])
    @par = params[:id]
    respond_with(@client) do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to clients_path, notice:"Developer was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    respond_with(@client)
  end


private
  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  

 
end
