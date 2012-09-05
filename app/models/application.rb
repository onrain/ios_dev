class Application < ActiveRecord::Base
  attr_accessible :bundle_identifier, :bundle_version, :product_name, :project_id, :relative_path, :title
end
