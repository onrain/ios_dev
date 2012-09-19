module ApplicationsHelper
  def set_layouts
		path = request.fullpath
		case path
		  when /admin\/clients/
        res = javascript_include_tag "clients"
        res += javascript_include_tag
      when /admin\/companies/
        res = javascript_include_tag(:companies)
        res += stylesheet_link_tag "companies"
      when /admin\/managers/
        javascript_include_tag(:managers)
        stylesheet_link_tag "managers"
      when /admin\/developers/
        javascript_include_tag(:developers)
        stylesheet_link_tag "developers"
      when /admin\/projects/
        res = javascript_include_tag(:projects)
         res += stylesheet_link_tag "projects"
      when /admin\/projects/
        javascript_include_tag(:applications)
        stylesheet_link_tag "applications"
		end
    res
  end
end
