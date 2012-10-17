class ApplicationsController < ApplicationController
  respond_to :json, :html, :xml
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_admin!

  def index
    
    get_notice(params[:notice], 'Applications was successfully create.', 'Applications was successfully updated.')

    unless params[:get].blank?
      @get_app_in_admin_index = Application.find_all_by_project_id(params[:id])
      @get_app_in_admin_index = Application.find(params[:id]) if params[:get].eql? 'app'
      return render json: @get_app_in_admin_index
    end
    

    return(render json: Application.find_all_by_bundle_identifier(params[:val])) unless params[:check].blank?

    duplicate(params[:id]); return render json: [nothink:true] unless params[:method].blank?



    @applications = Application.get_app_list.page(params[:page]).per(10).order("#{sort_column} #{sort_direction}")

    respond_with(@applications)
  end

  def show
    @application = Application.get_app_list_where_id(params[:id])
  end


  def new
   @application = Application.new
  end


  def edit
    @application = Application.find(params[:id])
  end

  def remote_update
    @application = Application.find(params[:id])

    respond_with(@application) do |format|
      if @application.update_attributes(params[:application])
        format.json { render json: Application.find(params[:id]) }
      else
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @application = Application.new(params[:application])

    respond_with(@application) do |format|
      if @application.save
        bundle_ident = params[:application][:bundle_identifier]
        project_version = params[:application][:bundle_version]
        
        Dir.mkdir("#{Rails.public_path}/#{bundle_ident}", 0700) unless File.directory?("#{Rails.public_path}/#{bundle_ident}")
        Dir.mkdir("#{Rails.public_path}/#{bundle_ident}/#{project_version}", 0700) unless File.directory?("#{Rails.public_path}/#{bundle_ident}/#{project_version}")

        File.open("#{Rails.public_path}/#{bundle_ident}/#{project_version}/readme.txt", 'w')do |file|
          file.write "Product mame: #{params[:application][:product_name]} \n"
          file.write "Bundle identifier: #{bundle_ident} \n"
          file.write "Bundle version: #{project_version}"
        end


        proj_id = params[:application][:project_id]
        format.html { redirect_to applications_path+'?n=created' }
        format.json { render json: Application.where(project_id:proj_id), status: :created, location: @application }
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @application = Application.find(params[:id])

    respond_with(@application) do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to applications_path+'?n=updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @application = Application.find(params[:id])
    #helper method
    delete_application_folder @application

    @application.destroy
    respond_with(@application) do |format|
      format.html { redirect_to applications_url }
      format.json { render json: [status:'deleted'] }

    end
  end

private
  def duplicate(id)
    app = Application.find(id)
    max_id = Application.find(:first, :select => 'max(id) as max').max
    max_id = max_id.to_i+1
    app.id = max_id.to_s
    app.title += " copy"
    app.product_name += " copy"
    app.relative_path += "/copy/"

    v = Application.where("bundle_identifier = ?",app.bundle_identifier).maximum('bundle_version')

    version = v.to_f + 0.1

    version = (version*1000).floor / 1000.0
    app.bundle_version = version.to_s
    Dir.mkdir("#{Rails.public_path}/#{app.bundle_identifier}", 0700) unless File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
    Dir.mkdir("#{Rails.public_path}/#{app.bundle_identifier}/#{app.bundle_version}", 0700) unless File.directory?("#{Rails.public_path}/#{app.bundle_identifier}/#{app.bundle_version}")

    File.open("#{Rails.public_path}/#{app.bundle_identifier}/#{app.bundle_version}/readme.txt", 'w')do |file|
      file.write "Product mame: #{app.product_name} \n"
      file.write "Bundle identifier: #{app.bundle_identifier} \n"
      file.write "Bundle version: #{app.bundle_version}"
    end
    clone_app = Application.create(app.attributes)
  end


end