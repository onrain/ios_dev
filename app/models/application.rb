class Application < ActiveRecord::Base
  attr_accessible :bundle_identifier, :bundle_version, :product_name, :project_id, :relative_path, :title, :id, :created_at, :updated_at
  validates :title, presence:true
  validates :product_name, presence:true, uniqueness:true
  validates :bundle_identifier, presence:true
  belongs_to :project
  #validates :relative_path, presence:true, uniqueness:true

end
