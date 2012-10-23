class CompaniesController < ApplicationController
  respond_to :json, :html, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!

  
  def index

    get_notice(params[:notice], 'Company was successfully create.', 'Company was successfully updated.')

    @companies = Company.page(params[:page]).per(10).order(sort_column(Company) + " " + sort_direction)
    
		unless params[:type].blank?
      company_details = Hash.new { |hash, key| hash[key] = [] }
      company = Company.find(params[:id])
      clients = company.clients.select('id, name')
      company_details['clients'] << clients unless  clients.empty?
      for client in clients
        projects = client.projects.select('id, name')
        company_details['project'] << projects unless projects.empty?
        for project in projects
          company_details['application'] << project.applications.select('id, product_name') unless  project.applications.empty?
        end
      end
      return render(json: company_details)
		end


    
    unless params[:method].blank? 
      method = params[:method]
      com_id = params[:com_id]
      if method.eql? 'delete'
        
        Company.find(com_id).clients.collect do |client|
					Project.find_all_by_client_id(client.id).collect do |project|
						delete_application_folder_relation project.applications
					end
		  	end
        return render json: [status:"deleted"]
      
      elsif method.eql? 'move'
        Company.find(com_id).clients.collect do |client|
					Project.find_all_by_client_id(client.id).collect do |project|
						move_application_f_list project.applications
					end
		  	end
        return render json: [status:'moved']
      end
    end



    respond_with(@companies) do |format|
      format.json{render json: Company.all}
    end
  end


  def show
    @client = Client.new

    @clients = Client.where(company_id:params[:id])

    @company_show = Company.find(params[:id])

    respond_with  @company = Company.new
  end


  def new
    respond_with  @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end


  def create
    @company = Company.new(params[:company])

    respond_with(@company) do |format|
      if @company.save
        @last = Company.last
        format.html { redirect_to companies_path+'?notice=created' }
        format.json { render json: @last }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @company = Company.find(params[:id])

    respond_with(@company) do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to companies_path+'?notice=updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @company = Company.find(params[:id])
    delete_relations(params[:id])
    @company.destroy
    redirect_to companies_path
  end


  private
  def delete_relations(company_id)  
    company = Company.find(company_id)
    client = company.clients.collect do |c|
      for proj in c.projects
        delete_application_folder_relation proj.applications
        proj.applications.delete_all
      end

    end
  end



end
