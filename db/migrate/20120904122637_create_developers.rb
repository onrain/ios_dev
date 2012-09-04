class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.integer :manager_id
      t.string :email
      t.string :personal_email

      t.timestamps
    end
  end
end
