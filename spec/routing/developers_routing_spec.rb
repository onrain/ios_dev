require "spec_helper"

describe DevelopersController do
  describe "routing" do

    it "routes to #index" do
      get("admin/developers").should route_to("developers#index")
    end

    it "routes to #new" do
      get("admin/developers/new").should route_to("developers#new")
    end

    it "routes to #show" do
      get("admin/developers/1").should route_to("developers#show", :id => "1")
    end

    it "routes to #edit" do
      get("admin/developers/1/edit").should route_to("developers#edit", :id => "1")
    end

    it "routes to #create" do
      post("admin/developers").should route_to("developers#create")
    end

    it "routes to #update" do
      put("admin/developers/1").should route_to("developers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("admin/developers/1").should route_to("developers#destroy", :id => "1")
    end

  end
end
