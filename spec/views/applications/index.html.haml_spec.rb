require 'spec_helper'

describe "applications/index" do
  before(:each) do
    assign(:applications, [
      stub_model(Application,
        :project_id => 1,
        :product_name => "Product Name",
        :bundle_identifier => "Bundle Identifier",
        :bundle_version => "Bundle Version",
        :relative_path => "Relative Path",
        :title => "Title"
      ),
      stub_model(Application,
        :project_id => 1,
        :product_name => "Product Name",
        :bundle_identifier => "Bundle Identifier",
        :bundle_version => "Bundle Version",
        :relative_path => "Relative Path",
        :title => "Title"
      )
    ])
  end

  it "renders a list of applications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Product Name".to_s, :count => 2
    assert_select "tr>td", :text => "Bundle Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Bundle Version".to_s, :count => 2
    assert_select "tr>td", :text => "Relative Path".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
