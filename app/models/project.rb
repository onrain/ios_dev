class Project < ActiveRecord::Base
  attr_accessible :id, :client_id, :handle, :manager_id, :name, :developer_ids
  validates :name, presence:true
  has_and_belongs_to_many :developers
  has_many :applications, :dependent => :destroy
  scope :get_proj_list,
    select:"projects.*, managers.name as manager_name, clients.name as client_name",
    joins:"left join managers on managers.id = projects.manager_id left join clients on clients.id = projects.client_id"
  
  scope :get_proj_list_where_id, lambda { |e|
    select("projects.*, managers.name as manager_name, clients.name as client_name")
    .joins("left join managers on managers.id = projects.manager_id left join clients on clients.id = projects.client_id")
    .where("projects.id = ? ",e)
  }
  
end
