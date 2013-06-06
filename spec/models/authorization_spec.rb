require 'spec_helper'

describe Authorization do
  let(:user) { create :user }
  let(:client) { create :application }

  let(:request_params) do
    {
      client_id:     client.uid,
      redirect_uri:  client.redirect_uri,
      response_type: "code"
    }
  end

  subject {
    Authorization.new(user, request_params)
  }

  it "should have valid client application" do
    subject.client.uid.should eq client.uid
  end

  it "should authorize the client user" do
    subject.authorization.should_not be_nil
  end

  it "should grant access token to client application" do
    subject.grant_token.should_not be_nil
  end
end
