require "spec_helper"

describe ClientsController do
  describe "routing" do

    it "routes to #index" do
      get("admin/clients").should route_to("clients#index")
    end

    it "routes to #new" do
      get("admin/clients/new").should route_to("clients#new")
    end

    it "routes to #show" do
      get("admin/clients/1").should route_to("clients#show", :id => "1")
    end

    it "routes to #edit" do
      get("admin/clients/1/edit").should route_to("clients#edit", :id => "1")
    end

    it "routes to #create" do
      post("admin/clients").should route_to("clients#create")
    end

    it "routes to #update" do
      put("admin/clients/1").should route_to("clients#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("admin/clients/1").should route_to("clients#destroy", :id => "1")
    end

  end
end
