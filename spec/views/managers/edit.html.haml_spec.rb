require 'spec_helper'

describe "managers/edit" do
  before(:each) do
    @manager = assign(:manager, stub_model(Manager,
      :name => "MyString",
      :personal_email => "MyString",
      :office_email => "MyString"
    ))
  end

  it "renders the edit manager form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => managers_path(@manager), :method => "post" do
      assert_select "input#manager_name", :name => "manager[name]"
      assert_select "input#manager_personal_email", :name => "manager[personal_email]"
      assert_select "input#manager_office_email", :name => "manager[office_email]"
    end
  end
end
