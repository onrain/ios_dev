require 'spec_helper'

describe "managers/index" do
  before(:each) do
    assign(:managers, [
      stub_model(Manager,
        :name => "Name",
        :personal_email => "Personal Email",
        :office_email => "Office Email"
      ),
      stub_model(Manager,
        :name => "Name",
        :personal_email => "Personal Email",
        :office_email => "Office Email"
      )
    ])
  end

  it "renders a list of managers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Personal Email".to_s, :count => 2
    assert_select "tr>td", :text => "Office Email".to_s, :count => 2
  end
end
