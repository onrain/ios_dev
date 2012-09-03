class Client < ActiveRecord::Base
  attr_accessible :company_id, :email, :handle, :name
  belongs_to :company
  
  scope :client_list, lambda { joins(:company).select("companies.name as company_name, clients.id, clients.company_id, clients.name, clients.email, clients.handle") }  
  
  scope :client_show, lambda { |e| joins(:company).select("companies.name as company_name, clients.id, clients.company_id, clients.name, clients.email, clients.handle").where("clients.id = #{e}") }  
end
