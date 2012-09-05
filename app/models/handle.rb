class Handle < ActiveRecord::Base
  attr_accessible :client_id, :handle_name
  belongs_to :client
  validates :handle_name, uniqueness:true, presence:true
end
