class Client < ActiveRecord::Base
  attr_accessible :company_id, :email, :handle, :name
  belongs_to :company
  
  
end
