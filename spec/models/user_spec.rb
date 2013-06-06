require 'spec_helper'

describe User do

  let(:user) { create :user }

  subject { user }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many :authentications }

  it "should return json" do
    user = create :user, email: "foo@bar.com"
    hash = {
        provider: 'sample',
        id: user.id.to_s,
        email: "foo@bar.com",
        info: {
          email: "foo@bar.com"
        }
    }
    user.to_json.should eq hash.to_json
  end

  it "should delete associate child records" do
    user = create :user
    create :authentication, :user => user
    lambda {
      user.destroy
    }.should change(Authentication, :count).by(-1)
  end
end
