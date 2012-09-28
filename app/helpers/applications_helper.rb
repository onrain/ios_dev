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
        res = javascript_include_tag(:managers)
        res += stylesheet_link_tag "managers"
      when /admin\/developers/
        res =javascript_include_tag(:developers)
        res += stylesheet_link_tag "developers"
      when /admin\/projects/
        res = javascript_include_tag(:projects)
        res += stylesheet_link_tag "projects"
      when /admin\/applications/
        res = javascript_include_tag(:applications)
        res += stylesheet_link_tag "applications"
		end
    res
  end
end
