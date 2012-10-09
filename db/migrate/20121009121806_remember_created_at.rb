class RememberCreatedAt < ActiveRecord::Migration
  def change
    change_column :admins, :remember_created_at, :datetime
  end
end
