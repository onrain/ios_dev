class Client < ActiveRecord::Base
  attr_accessible :company_id, :email, :handle, :name
  belongs_to :company
  has_many :handles, :dependent=>:destroy
  
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :name, presence:true
  
  scope :client_list, lambda { joins(:company).select("companies.name as company_name, clients.*") }  
  
  scope :client_show, lambda { |e| joins(:company).select("companies.name as company_name, clients.*").where("clients.id = #{e}") }  
end
