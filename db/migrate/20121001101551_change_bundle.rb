class ChangeBundle < ActiveRecord::Migration
  def change
    change_column :applications, :bundle_identifier, :string
  end
end
