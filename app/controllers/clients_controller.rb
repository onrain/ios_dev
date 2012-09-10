class ClientsController < ApplicationController
  respond_to :json, :html, :xml
  

  def index
    
    @clients = Client.get_clients_list 
    

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
    
    @show_handle = @client.handles.all

    
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
    hand = params[:client][:name].to_s
    @client.handle = hand.gsub(" ", ".").downcase
    
    @client.handles.create(handle_name:hand.gsub(" ", ".").downcase) if @client.save
    
    respond_with(@client) do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @client = Client.find(params[:id])
    @par = params[:id]
    respond_with(@client) do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
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
  
  
end
