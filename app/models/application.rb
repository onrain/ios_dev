class Application < ActiveRecord::Base
  attr_accessible :bundle_identifier, :bundle_version, :product_name, :project_id, :relative_path, :title
  validates :title, presence:true
  validates :product_name, presence:true

  scope :get_app_list,
    select:"applications.*, projects.name as project_name",
    joins:"left join projects on projects.id = applications.project_id"
  
  scope :get_app_list_where_id, lambda{ |e|
    select("applications.*, projects.name as project_name")
    .joins("left join projects on projects.id = applications.project_id")
    .where("applications.id = ? ",e)
  }
    

end
