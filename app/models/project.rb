class Project < ActiveRecord::Base
  attr_accessible :client_id, :handle, :manager_id, :name, :svn
  validates :name, presence:true
end
