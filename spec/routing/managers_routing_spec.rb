require "spec_helper"

describe ManagersController do
  describe "routing" do

    it "routes to #index" do
      get("/managers").should route_to("managers#index")
    end

    it "routes to #new" do
      get("/managers/new").should route_to("managers#new")
    end

    it "routes to #show" do
      get("/managers/1").should route_to("managers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/managers/1/edit").should route_to("managers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/managers").should route_to("managers#create")
    end

    it "routes to #update" do
      put("/managers/1").should route_to("managers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/managers/1").should route_to("managers#destroy", :id => "1")
    end

  end
end
