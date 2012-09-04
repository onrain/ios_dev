class ClientsController < ApplicationController
  respond_to :xml, :html, :json
  
  
  
  def index
    
    @clients = Client.find_by_sql(
     "SELECT companies.name as company_name, clients.* FROM clients
      LEFT JOIN companies ON companies.id = clients.company_id")
    

    respond_with(@clients)
  end


  def show
    @client = Client.find_by_sql(
     "SELECT companies.name as company_name, clients.* FROM clients
      LEFT JOIN companies ON companies.id = clients.company_id where clients.id=#{params[:id]}")
    respond_with(@client)
  end


  def new
    @client = Client.new
    @company = Company.new
    respond_with(@client)
  end


  def edit
    @company = Company.new
    @client = Client.find(params[:id])
  end


  def create
    @client = Client.new(params[:client])
    @company = Company.new

    hand = params[:client][:name].to_s
    @client.handle = hand.gsub(" ", ".").downcase

    
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
