class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :client_id
      t.integer :manager_id
      t.string :name
      t.string :handle

      t.timestamps
    end
  end
end
