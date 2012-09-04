class Project < ActiveRecord::Base
  attr_accessible :client_id, :handle, :manager_id, :name, :svn, :developer_ids
  validates :name, presence:true
  has_and_belongs_to_many :developers
end
