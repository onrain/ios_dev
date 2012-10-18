class Application < ActiveRecord::Base
  attr_accessible :bundle_identifier, :bundle_version, :product_name, :project_id, :relative_path, :title, :id, :created_at, :updated_at
  validates :title, presence:true
  validates :product_name, presence:true, uniqueness:true
  validates :bundle_identifier, presence:true
  belongs_to :project
  #validates :relative_path, presence:true, uniqueness:true
  #validates :bundle_identifier, presence:true, uniqueness:true

  scope :get_app_list,
    select:"applications.*, projects.name as project_name",
    joins:"left join projects on projects.id = applications.project_id"
  
  scope :get_app_list_where_id, lambda{ |e|
    select("applications.*, projects.name as project_name")
    .joins("left join projects on projects.id = applications.project_id")
    .where("applications.id = ? ",e)
  }
    

end
