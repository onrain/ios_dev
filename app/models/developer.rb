class Developer < ActiveRecord::Base
  attr_accessible :email, :manager_id, :name, :personal_email
  validates :name, presence:true
  validates :manager, presence:true
  has_and_belongs_to_many :projects
  belongs_to :manager
  

  scope :get_dev_list,
     select:"managers.name as manager_name, developers.*",
     joins:"LEFT JOIN managers ON managers.id = developers.manager_id"

  scope :get_dev_list_where_id, lambda{ |e|
    select("managers.name as manager_name, developers.*")
    .joins("LEFT JOIN managers ON managers.id = developers.manager_id")
    .where("developers.id = ?",e)
  }
end
