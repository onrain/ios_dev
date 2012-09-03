class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :company_id
      t.string :name
      t.string :email
      t.string :handle

      t.timestamps
    end
  end
end
