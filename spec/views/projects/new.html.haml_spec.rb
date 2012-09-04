require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :client_id => 1,
      :manager_id => 1,
      :name => "MyString",
      :svn => "MyString",
      :handle => "MyString"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_client_id", :name => "project[client_id]"
      assert_select "input#project_manager_id", :name => "project[manager_id]"
      assert_select "input#project_name", :name => "project[name]"
      assert_select "input#project_svn", :name => "project[svn]"
      assert_select "input#project_handle", :name => "project[handle]"
    end
  end
end
