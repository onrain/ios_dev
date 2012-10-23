module ApplicationHelper

  def check_path(name, id, path = Hash.new)
    id = id.to_s
    if name.nil?
      name = content_tag(:div, 'empty', style: "color:gray; font-size:13px;")
    else
      name =  link_to name, "/admin/#{path[:path]}/#{id}"
    end
    name
  end
  
  def check_f(param)
    content_tag(:div, 'empty', style: "color:gray; font-size:13px;") if param.nil? or param.empty?
    param
  end


  def set_time(current_time)
    return "" if current_time.nil?
    current_time.strftime('%B %d, %Y at %H:%M')
  end


  def sort_column(model_name)
    model_name.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

	def get_notice(notice_type, message_create, message_update)
    flash[:notice] = nil

    unless notice_type.blank?
      case(notice_type)
        when 'updated' then flash[:notice] = message_update
        when 'created' then flash[:notice] = message_create
        else return nil 
      end
    end
	
	end


  def set_layouts
		path = request.fullpath
		case path
		when /admin\/clients/
      res = javascript_include_tag "clients"
    when /admin\/companies/
      res = javascript_include_tag(:companies)
    when /admin\/managers/
      res = javascript_include_tag(:managers)
    when /admin\/developers/
      res =javascript_include_tag(:developers)
    when /admin\/projects/
      res = javascript_include_tag(:projects)
    when /admin\/applications/
      res = javascript_include_tag(:applications)
		end
    res
  end





  def error_field(class_name, width)
    lambda {
			content_tag(:div, class:'alert alert-error', style:"width:#{width.to_s}px; margin: 0 auto;") do
				link_to("x", '#', class:'close', :'data-dismiss' => :'alert') +
				content_tag(:h3, "#{pluralize(class_name.errors.count, "error")} prohibited this post from being saved:") +
				content_tag(:ul) do
					class_name.errors.full_messages.each do |msg|
					  concat content_tag(:li, msg)
				  end 
				end
			end
		}.call if class_name.errors.any?
  end


  def print_notice(notice, width=950)
    lambda {
		  content_tag(:div, class:'alert alert-success', style:"width:#{width.to_s}px; margin: 0 auto;") do
        content_tag(:button, 'x', class:'close', :'data-dismiss'=>:'alert') +
        notice
      end
		}.call if notice
  end


  def delete_application_folder(app)
    public_dir_size = Dir["#{Rails.public_path}/#{app.bundle_identifier}/*"].size
    if public_dir_size.eql? 1
      FileUtils.rm_rf("#{Rails.public_path}/#{app.bundle_identifier}") if File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
    elsif public_dir_size > 1
      FileUtils.rm_rf("#{Rails.public_path}/#{app.bundle_identifier}/#{app.bundle_version}") if File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
    end
  end

  def delete_application_folder_relation(application)
    for app in application
	    public_dir_size = Dir["#{Rails.public_path}/#{app.bundle_identifier}/*"].size
      if public_dir_size.eql? 1
        FileUtils.rm_rf("#{Rails.public_path}/#{app.bundle_identifier}") if File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
      elsif public_dir_size > 1
        FileUtils.rm_rf("#{Rails.public_path}/#{app.bundle_identifier}/#{app.bundle_version}") if File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
      end
    end
  end
  
  def move_application_f(app)
	  Dir.mkdir("#{Rails.public_path}/deleted") if Dir["#{Rails.public_path}/deleted"].size.eql? 0 
		FileUtils.mv("#{Rails.public_path}/#{app.bundle_identifier}","#{Rails.public_path}/deleted") if File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
  end
  
  
  def move_application_f_list(applications)
		Dir.mkdir("#{Rails.public_path}/deleted") if Dir["#{Rails.public_path}/deleted"].size.eql? 0 
		for app in applications
		  FileUtils.mv("#{Rails.public_path}/#{app.bundle_identifier}","#{Rails.public_path}/deleted") if File.directory?("#{Rails.public_path}/#{app.bundle_identifier}")
		end
  end

end
