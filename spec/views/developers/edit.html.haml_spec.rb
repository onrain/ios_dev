require 'spec_helper'

describe "developers/edit" do
  before(:each) do
    @developer = assign(:developer, stub_model(Developer,
      :name => "MyString",
      :manager_id => 1,
      :email => "MyString",
      :personal_email => "MyString"
    ))
  end

  it "renders the edit developer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => developers_path(@developer), :method => "post" do
      assert_select "input#developer_name", :name => "developer[name]"
      assert_select "input#developer_manager_id", :name => "developer[manager_id]"
      assert_select "input#developer_email", :name => "developer[email]"
      assert_select "input#developer_personal_email", :name => "developer[personal_email]"
    end
  end
end
