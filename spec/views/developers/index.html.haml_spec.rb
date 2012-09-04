require 'spec_helper'

describe "developers/index" do
  before(:each) do
    assign(:developers, [
      stub_model(Developer,
        :name => "Name",
        :manager_id => 1,
        :email => "Email",
        :personal_email => "Personal Email"
      ),
      stub_model(Developer,
        :name => "Name",
        :manager_id => 1,
        :email => "Email",
        :personal_email => "Personal Email"
      )
    ])
  end

  it "renders a list of developers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Personal Email".to_s, :count => 2
  end
end
