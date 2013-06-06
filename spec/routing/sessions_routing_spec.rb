require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #new" do
      get("/auth/identity").should route_to("sessions#new")
    end

    it "routes to #create" do
      post("/auth/identity/callback").should route_to("sessions#create", :provider => 'identity')
    end

    it "routes to #failure" do
      get("/auth/failure").should route_to("sessions#failure")
    end

    it "routes to #destroy" do
      delete("/signout").should route_to("sessions#destroy")
    end
  end
end
