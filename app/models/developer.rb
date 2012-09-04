class Developer < ActiveRecord::Base
  attr_accessible :email, :manager_id, :name, :personal_email
  validates :name, presence:true
end
