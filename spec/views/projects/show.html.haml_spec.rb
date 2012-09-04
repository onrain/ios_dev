require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :client_id => 1,
      :manager_id => 2,
      :name => "Name",
      :svn => "Svn",
      :handle => "Handle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/Svn/)
    rendered.should match(/Handle/)
  end
end
