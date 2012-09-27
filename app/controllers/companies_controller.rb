class CompaniesController < ApplicationController
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

    @companies = Company.page(params[:page]).per(10).order(sort_column + " " + sort_direction)
    @res = Company.last
    respond_with(@companies) do |format|
      format.json{render json: @res}
    end
  end


  def show
    @client = Client.new
    @company = Company.new
    @clients = Client.where(company_id:params[:id])

    @company_show = Company.find(params[:id])

    respond_with @company
  end


  def new
    @company = Company.new

    respond_with @company
  end

  def edit
    @company = Company.find(params[:id])
  end


  def create
    @company = Company.new(params[:company])

    respond_with(@company) do |format|
      if @company.save
        @last = Company.last
        format.html { redirect_to @company, companies_path+'?n=created' }
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
        format.html { redirect_to companies_path+'?n=updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_with(@company)
  end

private
  def sort_column
    Company.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  

end
