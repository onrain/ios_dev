require 'spec_helper'

describe Application do

  before(:all) do
    @applications = FactoryGirl.create(:application)
  end

  
  it 'should be create new application' do
     @applications.id.size.should_not eq(0)
  end
  
  
  it { should validate_presence_of(:title) }
 
 
  it { should validate_presence_of(:product_name) }
  
  it "should be create new title" do
    Application.create(title:"new title").should have(:no).errors_on(:title)

    app = Application.where(title:"new title")
    
      for p in app
      
        p.title.should eq("new title")
        
      end   
  end
  
  it "should be delete application" do 
    app = Application.where(title:"new title")
    
    app.delete_all
    
    app.should be_empty
  end
  
  it "should be insert new project" do
    Application.create(project_id:"2").should have(:no).errors_on(:project_id)
    
    app = Application.where(project_id:"2")
    
    for p in app
    
      p.project_id.should eq("2")
    end
  end
  
  it "should be edit application" do
    @applications.title.clear
    
    @applications.title << 'new title'
    
    @applications.title.should eq('new title')

  end
end
