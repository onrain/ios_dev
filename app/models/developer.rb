class Developer < ActiveRecord::Base
  attr_accessible :email, :manager_id, :name, :personal_email
  validates :name, presence:true
  has_and_belongs_to_many :projects
  belongs_to :manager
end
