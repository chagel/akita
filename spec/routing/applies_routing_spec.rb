require "spec_helper"

describe AppliesController do
  describe "routing" do

    it "routes to #index" do
      get("/applies").should route_to("applies#index")
    end

    it "routes to #new" do
      get("/applies/new").should route_to("applies#new")
    end

    it "routes to #show" do
      get("/applies/1").should route_to("applies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/applies/1/edit").should route_to("applies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/applies").should route_to("applies#create")
    end

    it "routes to #update" do
      put("/applies/1").should route_to("applies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/applies/1").should route_to("applies#destroy", :id => "1")
    end

  end
end
