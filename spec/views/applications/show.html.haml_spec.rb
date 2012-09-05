require 'spec_helper'

describe "applications/show" do
  before(:each) do
    @application = assign(:application, stub_model(Application,
      :project_id => 1,
      :product_name => "Product Name",
      :bundle_identifier => "Bundle Identifier",
      :bundle_version => "Bundle Version",
      :relative_path => "Relative Path",
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Product Name/)
    rendered.should match(/Bundle Identifier/)
    rendered.should match(/Bundle Version/)
    rendered.should match(/Relative Path/)
    rendered.should match(/Title/)
  end
end
