class CompaniesController < ApplicationController
  respond_to :json, :html, :xml
  
  
  def index
    @companies = Company.all
    @res = Company.last
    respond_with(@companies) do |format|
      format.json{render json: @res}
    end
    
  end


  def show
    @company = Company.find(params[:id])

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
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
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
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
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
end
