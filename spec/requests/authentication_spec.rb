require 'spec_helper'

describe "Authentication" do
  let (:current_user) { create :user }
  let (:authentication) { create :authentication, user: current_user }

  before(:each) do
    @client = create :application
    current_user.save
    authentication.save
    OmniAuth.config.add_mock authentication.provider, { :uid => authentication.uid }
  end

  it "user should able to signup with identity", :mechanize, :vcr do
    visit authorization_endpoint_url(@client)

    within ".register" do
      fill_in "Email",            :with => "person@bar.com"
      fill_in "Password",         :with => "password"
      click_button "Signup"
    end

    i_should_be_on_client_app
  end

  it "should sign in using omniauth provider", :omniauth, :mechanize, :vcr do
    visit authorization_endpoint_url(@client)
    i_should_be_on_client_app
  end

#TODO: This feature is on pipeline
  pending "existing user can able to add another authentication to his account", :omniauth do

    visit authorization_endpoint_url(@client)

    visit signin_form_path

    omniauth_facebook_driver

    current_user.authentications.count.should eq 1

    click_link "Facebook"

    current_user.authentications.count.should eq 2

    page.current_path.should eq "/"
  end

  it "should send failure notice if user doesn't exists" do
    visit signin_form_path

    within ".login" do
      fill_in "Email",    :with => "foo@bar.com"
      fill_in "Password", :with => "password"
      click_button 'Login'
    end

    current_path.should eq signin_form_path
  end

  it "existing user should be able to login with identity", :mechanize, :vcr do
    identity       = create :identity, password: "password"
    user           = create :user, email: identity.email
    authentication = create :authentication, user: user, uid: identity.id, provider: "identity"

    visit authorization_endpoint_url(@client)

    within ".login" do
      fill_in "Email",    :with => user.email
      fill_in "Password", :with => "password"
      click_button 'Login'
    end

    i_should_be_on_client_app
  end
end
