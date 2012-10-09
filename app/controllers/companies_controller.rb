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
    delete_relations(params[:id])
    @company.destroy
    redirect_to companies_path
  end


private
  def delete_relations(company_id)  
    company = Company.find(company_id)
    client = company.clients
    for c in client
      project = Project.find_all_by_client_id(c)
      for p in project
        application = Application.find_all_by_project_id(p)
        for app in application
          Application.delete(app.id)
        end
      end
    end
  end



end
