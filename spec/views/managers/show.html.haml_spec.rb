require 'spec_helper'

describe "managers/show" do
  before(:each) do
    @manager = assign(:manager, stub_model(Manager,
      :name => "Name",
      :personal_email => "Personal Email",
      :office_email => "Office Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Personal Email/)
    rendered.should match(/Office Email/)
  end
end
