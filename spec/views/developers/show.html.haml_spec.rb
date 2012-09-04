require 'spec_helper'

describe "developers/show" do
  before(:each) do
    @developer = assign(:developer, stub_model(Developer,
      :name => "Name",
      :manager_id => 1,
      :email => "Email",
      :personal_email => "Personal Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Email/)
    rendered.should match(/Personal Email/)
  end
end
