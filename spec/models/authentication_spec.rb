require 'spec_helper'

describe Authentication do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :uid }
  it {
    create :authentication
    should validate_uniqueness_of(:uid).scoped_to(:provider)
  }

end
