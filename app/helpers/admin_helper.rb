module AdminHelper

	def sortable(column, title = nil)

    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
		link_to title, {:sort => column, :direction => direction}, {:class => 'sort', :id => column}
	end

  def app_link(title, type, id=nil)
    unless id.nil?
      res = "<a id='#{id}' href='#' class='get-list-"+type+"'>"+title+"</a>"
    else
      res = "<span id='' class='get-list-developers'>"+title+"</span>"
    end
      res.html_safe
  end

end
