require 'spec_helper'

describe "applications/edit" do
  before(:each) do
    @application = assign(:application, stub_model(Application,
      :project_id => 1,
      :product_name => "MyString",
      :bundle_identifier => "MyString",
      :bundle_version => "MyString",
      :relative_path => "MyString",
      :title => "MyString"
    ))
  end

  it "renders the edit application form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => applications_path(@application), :method => "post" do
      assert_select "input#application_project_id", :name => "application[project_id]"
      assert_select "input#application_product_name", :name => "application[product_name]"
      assert_select "input#application_bundle_identifier", :name => "application[bundle_identifier]"
      assert_select "input#application_bundle_version", :name => "application[bundle_version]"
      assert_select "input#application_relative_path", :name => "application[relative_path]"
      assert_select "input#application_title", :name => "application[title]"
    end
  end
end
