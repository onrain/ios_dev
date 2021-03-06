require 'spec_helper'

describe Client do
  before(:all) do
    @client = FactoryGirl.create(:client)
  end
  
  it 'should be create new application' do
    @client.id.size.should_not eq(0)
  end
  
  
  it { should validate_presence_of(:handle) }
  
  it "should be valid email" do
    FactoryGirl.build(:client, :email=>"").should_not be_valid
    
    FactoryGirl.build(:client, :email=>"new email").should_not be_valid
    
    FactoryGirl.build(:client, :email=>"test@test.com").should be_valid
    
    FactoryGirl.build(:client, :email=>"q@q@test.com").should_not be_valid
  end
  
  it "should be valid name" do
    FactoryGirl.build(:client, :name=>"").should_not be_valid
    
    FactoryGirl.build(:client, :name=>"NAME").should_not be_valid
  end  
  
  it "should be edit client name" do
    @client.name.clear
    
    @client.name << 'new name'
    
    @client.name.should eq('new name')
  end
  
  it "should be insert new client" do
    Client.create(handle:"company/client.test").should have(:no).errors_on(:handle)
    
    Client.where(handle:"company/client.test").collect do |c|
      c.handle.should eq("company/client.test")
    end
  end
  
  it "should be delete client" do
    client = Client.where(handle:"company/client.test")
    
    client.delete_all
    
    client.should be_empty
  end

end
