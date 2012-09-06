module ApplicationsHelper
  def set_layouts
		path = request.fullpath
		case path
		  when /clients/
        res = javascript_include_tag "clients"
        res += javascript_include_tag
      when /companies/
        javascript_include_tag(:companies)
        stylesheet_link_tag "companies"
      when /managers/
        javascript_include_tag(:managers)
        stylesheet_link_tag "managers"
      when /developers/
        javascript_include_tag(:developers)
        stylesheet_link_tag "developers"
      when /projects/
        javascript_include_tag(:projects)
        stylesheet_link_tag "projects"
      when /projects/
        javascript_include_tag(:applications)
        stylesheet_link_tag "applications"
		end
    res
  end
end
