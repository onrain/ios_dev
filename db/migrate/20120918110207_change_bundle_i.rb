class ChangeBundleI < ActiveRecord::Migration
  def change
    change_column :applications, :bundle_identifier, :float, :default =>  1.0
  end
end
