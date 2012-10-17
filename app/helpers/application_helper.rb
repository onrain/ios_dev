module ApplicationHelper

  def check_path(name, id, path = Hash.new)
    id = id.to_s
    if name.nil?
      name = "<div style='color:gray; font-size:13px;'>empty</div>"
    else
      name = "<a href='/admin/#{path[:path]}/#{id}'>"+name+"</a>"
    end
    name
  end
  
  def check_f(param)
    param ="<div style='color:gray; font-size:13px;'>empty</div>".html_safe  if param.nil? or param.empty?
    param
  end


  def set_time(current_time)
    return "" if current_time.nil?
    current_time.strftime('%B %d, %Y at %H:%M')
  end


  def sort_column
    Application.column_names.include?(params[:sort]) ? params[:sort] : "name"
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
        res += javascript_include_tag
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

    if class_name.errors.any?
      res = "<div class='alert alert-error' style='width:#{width.to_s}px; margin: 0 auto;'><a class='close' data-dismiss='alert' href='#'>&times;</a>
        <h3>#{pluralize(class_name.errors.count, "error")} prohibited this post from being saved:</h3>
        <ul>"
      class_name.errors.full_messages.each do |msg|
        res+="<li>#{msg}</li>"
      end
        res +="</ul></div>"
      return res.html_safe
    end
  end


  def print_notice(notice, width=950)
		return "<div class='alert alert-success' style='width:#{width.to_s}px; margin: 0 auto;'><button class='close' data-dismiss='alert'>x</button>#{notice}</div>".html_safe if notice
  end


  def delete_application_folder(app)
    public_dir_size = Dir["#{Rails.public_path}/#{app.bundle_identifier}/*"].size
    if public_dir_size.eql? 1
      FileUtils.rm_rf("#{Rails.public_path}/#{app.bundle_identifier}")
      #Dir.delete("#{Rails.public_path}/#{app.bundle_identifier}")
    elsif public_dir_size > 1
      FileUtils.rm_rf("#{Rails.public_path}/#{app.bundle_identifier}/#{app.bundle_version}")
    end
  end

end
