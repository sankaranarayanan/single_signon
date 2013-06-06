require "spec_helper"

describe "Password" do
  let(:identity) { create :identity, :password_reset_token => "123456" }
  let(:user) { create :user, :email => identity.email }
  let(:redirect_uri) { "http://fakewebfoo.com/auth/inv/callback" }

  it "reset password with email should send an email from a mailer" do
    user.save

    should_receive_password_reset_email(user, redirect_uri)

    visit_new_password_path(redirect_uri)

    fill_in 'Email', :with => identity.email

    click_button 'Reset Password'
  end

  it "should sign in user automatically after changing its password", :mechanize, :vcr do
    user.save
    visit edit_password_path(identity.password_reset_token, :redirect_uri => redirect_uri)

    fill_in 'Password', :with => "password"

    click_button "Update Password"

    i_should_be_on_client_app
  end

  def visit_new_password_path(redirect_uri)
    visit signin_form_path(:origin=> redirect_uri)
    click_link 'Forgot your password?'
  end
end
