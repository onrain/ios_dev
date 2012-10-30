require 'spec_helper'

describe Application do

  before(:all) do
    @applications = FactoryGirl.create(:application)
  end

  
  it 'should be create new application' do
     @applications.id.size.should_not eq(0)
  end
  
  
  it { should validate_presence_of(:title) }
  
  it { should_not validate_uniqueness_of(:bundle_identifier) }
  
  
  it { should validate_presence_of(:bundle_identifier) }
 
 
  it { should validate_presence_of(:product_name) }
  
  it "should be create new title" do
    Application.create(title:"new title").should have(:no).errors_on(:title)

    Application.where(title:"new title").collect { |p| p.title.should eq("new title") }
  end
  
  it "should be delete application" do 
    app = Application.where(title:"new title")
    app.delete_all
    
    app.should be_empty
  end
  
  
  it "should be duplicate application" do
    Application.delete_all
    FactoryGirl.create(:application)
    @app = Application.last
    @app.product_name.should eq("New product")
    @app.id = @app.id+1
    @app.title += " copy"
    @app.product_name += " copy"
    @app.bundle_version = "1.1"
    Application.create(@app.attributes)
    Application.last.bundle_version.should eq('1.1')
    #puts "all attr[]: -> #{Application.last.attributes}"
  end
  
  
  it "should be insert new project" do
    Application.create(project_id:"2").should have(:no).errors_on(:project_id)
    
    Application.where(project_id:"2").collect { |p| p.project_id.should eq("2") }
  end
  
  
  it "should be edit application" do
    @applications.title.clear
    
    @applications.title << 'new title'
    
    @applications.title.should eq('new title')

  end
end
