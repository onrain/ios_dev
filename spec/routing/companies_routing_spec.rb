require "spec_helper"

describe CompaniesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/companies").should route_to("companies#index")
    end

    it "routes to #new" do
      get("/admin/companies/new").should route_to("companies#new")
    end

    it "routes to #show" do
      get("/admin/companies/1").should route_to("companies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/companies/1/edit").should route_to("companies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/companies").should route_to("companies#create")
    end

    it "routes to #update" do
      put("/admin/companies/1").should route_to("companies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/companies/1").should route_to("companies#destroy", :id => "1")
    end

  end
end
