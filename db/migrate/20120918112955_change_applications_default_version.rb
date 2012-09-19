class ChangeApplicationsDefaultVersion < ActiveRecord::Migration
  def change
    change_column_default(:applications, :bundle_identifier, nil)
  end
end
