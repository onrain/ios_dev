class Client < ActiveRecord::Base
  
  attr_accessible :company_id, :email, :handle, :name
  belongs_to :company
  has_many :projects, :dependent => :delete_all
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :name, presence:true, length:{minimum:3, maximum:40}
  validates :handle, presence:true

end