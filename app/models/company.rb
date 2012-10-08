class Company < ActiveRecord::Base
  attr_accessible :id, :name, :website
  validates :name, presence:true, uniqueness:true
  has_many :clients, :dependent=>:destroy
  belongs_to :client
end





=begin

def delete_all
  client = Clilent.find_all_by_company_id(params[:id])
  
  for c in client
    project = Project.find_all_by_client_id(c.id)
    for proj in project
      application = Application.find_all_by_project_id(proj.id)
      application.destroy
    end
    
    project.destroy
  end




  
=end
