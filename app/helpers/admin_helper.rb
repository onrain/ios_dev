module AdminHelper

	def sortable(column, title = nil)

    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
		link_to title, {:sort => column, :direction => direction}, {:class => 'sort', :id => column}
	end

end
