class ChangeApplications < ActiveRecord::Migration
  def change
    change_column :applications, :bundle_identifier, :string
    change_column :applications, :bundle_version, :float, :default =>  1.0
  end
end
