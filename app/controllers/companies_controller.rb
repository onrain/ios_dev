class CompaniesController < ApplicationController
  respond_to :json, :html, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!

  
  def index

    get_notice(params[:notice], 'Company was successfully create.', 'Company was successfully updated.')

    @companies = Company.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    respond_with(@companies) do |format|
      format.json{render json: Company.last}
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
    
    delete_relations(params[:id]) if @company.destroy
    redirect_to companies_path
  end


private
  def delete_relations(company_id)
    client = Client.find_all_by_company_id(company_id)
    
    for c in client
      project = Project.where('client_id = ?',c.id)
      project.destroy
    end

    project = client.projects

    for proj in project
      application = Application.where('project_id = ?',proj.id)
      application.delete
    end


  end



end
