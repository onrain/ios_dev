require 'spec_helper'

describe "clients/edit" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :company_id => "",
      :name => "MyString",
      :email => "MyString",
      :handle => "MyString"
    ))
  end

  it "renders the edit client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clients_path(@client), :method => "post" do
      assert_select "input#client_company_id", :name => "client[company_id]"
      assert_select "input#client_name", :name => "client[name]"
      assert_select "input#client_email", :name => "client[email]"
      assert_select "input#client_handle", :name => "client[handle]"
    end
  end
end
