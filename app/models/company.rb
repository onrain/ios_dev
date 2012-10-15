class Company < ActiveRecord::Base
  attr_accessible :id, :name, :website
  validates :name, presence:true, uniqueness:true
  has_many :clients, :dependent=>:destroy
  belongs_to :client
end
