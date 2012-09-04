class CreateDevelopersProjectsTable < ActiveRecord::Migration
  def self.up
    create_table :developers_projects, :id => false do |t|
        t.references :developer
        t.references :project
    end
    add_index :developers_projects, [:developer_id, :project_id]
    add_index :developers_projects, [:project_id, :developer_id]
  end

  def self.down
    drop_table :developers_projects
  end

end
