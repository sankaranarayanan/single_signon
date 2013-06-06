require 'spec_helper'

describe Identity do
  let(:identity) { create :identity }
  let(:user) { create :user, :email => identity.email }

  subject { identity }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it "generates a unique password_reset_token each time" do
    user.save
    identity.send_password_reset
    last_token = identity.password_reset_token
    identity.send_password_reset
    identity.password_reset_token.should_not eq(last_token)
  end

  it "delivers email to user" do
    user.save
    should_receive_password_reset_email(user)
    identity.send_password_reset
  end
end
