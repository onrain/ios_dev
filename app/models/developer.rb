class Developer < ActiveRecord::Base
  attr_accessible :email, :manager_id, :name, :personal_email
  validates :name, presence:true
  validates :manager, presence:true
  has_and_belongs_to_many :projects
  belongs_to :manager
  validates :personal_email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
end
