class ClientsController < ApplicationController
  respond_to :xml, :html, :json
  
  
  
  def index
    @clients = Client.client_list
    respond_with(@clients)
  end


  def show
    @client = Client.client_show(params[:id])
    respond_with(@client)
  end


  def new
    @client = Client.new
    respond_with(@client)
  end


  def edit
    @client = Client.find(params[:id])
  end


  def create
    @client = Client.new(params[:client])

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
