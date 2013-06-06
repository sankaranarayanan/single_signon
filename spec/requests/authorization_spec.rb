require 'spec_helper'

describe "Authorization" do
  let (:current_user) { create :user }
  let (:authentication) { create :authentication, user: current_user }
  let (:application) {create :application }
  let (:token) { create :access_token, :application => application, :resource_owner_id => current_user.id }

  before(:each) do
    OmniAuth.config.add_mock authentication.provider, :uid => authentication.uid
  end

  it 'responds with 200' do
    get '/oauth/user', :format => :json, :access_token => token.token
    response.status.should eq(200)
  end

  it 'returns the user as json' do
    get '/oauth/user', :format => :json, :access_token => token.token
    response.body.should == current_user.to_json
  end
end
