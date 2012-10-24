class Project < ActiveRecord::Base
  attr_accessible :id, :client_id, :handle, :manager_id, :name, :developer_ids
  validates :name, presence:true
  has_and_belongs_to_many :developers
  has_many :applications, :dependent => :destroy
  
end
