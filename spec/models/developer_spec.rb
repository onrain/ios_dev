require 'spec_helper'

describe Developer do
  
  before(:all) do
    @developer = FactoryGirl.create(:developer)
  end
  
  it 'should be create new developer' do
    @developer.id.size.should_not eq(0)
  end
  
  
  it { should validate_presence_of(:manager_id) }
  
  
  it { should validate_presence_of(:name) }
  
  
  it { should validate_presence_of(:email) }
  
  
  it { should validate_presence_of(:personal_email) }
  
  
  
  it "should be valid and should not be valid name" do
    FactoryGirl.build(:developer, name:nil).should_not be_valid
    FactoryGirl.build(:developer, name:"111111").should be_valid
  end
  
  it "should be valid and should not be valid personal_email" do
    FactoryGirl.build(:developer, personal_email:nil).should_not be_valid
    FactoryGirl.build(:developer, personal_email:"email").should_not be_valid
    FactoryGirl.build(:developer, personal_email:"email.test").should_not be_valid
    FactoryGirl.build(:developer, personal_email:"email@email.com").should be_valid
  end
  
  it "should be edit developer" do
    @developer.name.clear
    @developer.name << "New Developer"
    @developer.name.should eq("New Developer")
  end
  
  it "should be create developer name" do
    @new_dev = Developer.create(name:"New Developer Test").should have(:no).errors_on(:name)
    Developer.where(name:"New Developer Test").collect { |dev| dev.name.should eq("New Developer Test") }
  end
  
  it "should be delete developer" do
    dev = Developer.where(name:"New Developer Test")
    dev.delete_all
    dev.should be_empty
  end
  
end
