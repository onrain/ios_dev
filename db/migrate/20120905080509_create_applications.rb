class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :project_id
      t.string :product_name
      t.string :bundle_identifier
      t.string :bundle_version, default:"1.0"
      t.string :relative_path
      t.string :title

      t.timestamps
    end
  end
end
