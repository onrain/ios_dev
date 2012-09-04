class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :name
      t.string :personal_email
      t.string :office_email

      t.timestamps
    end
  end
end
