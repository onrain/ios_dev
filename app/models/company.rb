class Company < ActiveRecord::Base
  attr_accessible :name, :website
  validates :name, presence:true
  has_many :clients, :dependent=>:destroy
  
end
