class CreateHandles < ActiveRecord::Migration
  def change
    create_table :handles do |t|
      t.integer :client_id
      t.string :handle_name

      t.timestamps
    end
  end
end
