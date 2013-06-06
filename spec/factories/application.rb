# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application, :class => Doorkeeper::Application do
    sequence(:name){ |n| "Application #{n}" }
    redirect_uri "http://fakewebfoo.com/auth/sample/callback"
  end
end
