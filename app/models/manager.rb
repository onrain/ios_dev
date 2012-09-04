class Manager < ActiveRecord::Base
  attr_accessible :name, :office_email, :personal_email
  validates :name, presence:true
  has_many :developers
end
