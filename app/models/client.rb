class Client < ActiveRecord::Base
  attr_accessible :company_id, :email, :handle, :name
  belongs_to :company
  
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :name, presence:true
  
  scope :client_list, lambda { joins(:company).select("companies.name as company_name, clients.id, clients.company_id, clients.name, clients.email, clients.handle") }  
  
  scope :client_show, lambda { |e| joins(:company).select("companies.name as company_name, clients.id, clients.company_id, clients.name, clients.email, clients.handle").where("clients.id = #{e}") }  
end
