require "spec_helper"

describe UsersController do
  describe "routing" do
    it "routes to #new" do
      get("/oauth/user").should route_to("users#show")
    end
  end
end
