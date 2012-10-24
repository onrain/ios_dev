class ClientsController < ApplicationController
  respond_to :json, :html, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!


  def index
    get_notice(params[:notice], 'Clients was successfully create.', 'Clients was successfully updated.')

    return (render json: Client.find(params[:handle])) unless params[:handle].blank?

    return (render json: Client.find(params[:id])) unless params[:get].blank?
    
    
    
    unless params[:method].blank? 
      method = params[:method]
      client_id = params[:client_id]
      
      if method.eql? 'delete'
        Project.find_all_by_client_id(client_id).collect do |project|
          delete_application_folder_relation project.applications
        end
        return render json: [status:"deleted"]
      elsif method.eql? 'move'
        Project.find_all_by_client_id(client_id).collect do |project|
          move_application_f_list project.applications 
        end
        return render json: [status:'moved']
      end
    end
    
    unless params[:type].blank?
      project_application = Hash.new { |hash, key| hash[key] = [] }
      projects = Client.find(params[:id]).projects.select('id, name')
      project_application['project'] << projects unless projects.empty? 
      for project in projects
        project_application['application'] << project.applications unless project.applications.empty?
      end
      return render json: project_application.to_json
    end

    @clients = Client.joins("LEFT JOIN companies ON companies.id = clients.company_id").select('companies.name as company_name, clients.*').page(params[:page]).per(10).order(sort_column(Client) + " " + sort_direction)

    respond_with(@clients)
  end


  def show
    respond_with  @client = Client.get_clients_list_where_id(params[:id])
  end


  def new
    @company = Company.new

    @client = Client.new
  end
  

  def edit
    @company = Company.new
    @client = Client.find(params[:id])
  end


  def create
    @client = Client.new(params[:client])

    @company = Company.new

    company_client = params[:client][:company_id]

    respond_with(@client) do |format|
      if @client.save
        format.html { redirect_to clients_path+'?notice=created' }
        format.json { render json: Client.where("company_id = ?",company_client) }
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
    respond_with(@client) do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to clients_path+'?notice=updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @client = Client.find(params[:id])
    delete_relation(params[:id])
    @client.destroy
    redirect_to clients_path
  end
  
  private
  def delete_relation(client_id)
   Project.find_all_by_client_id(client_id).collect do |project|
      delete_application_folder_relation project.applications
      project.applications.delete_all
    end
  end


end
