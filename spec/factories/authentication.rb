# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    uid "12345"
    provider "default"
    user
  end
end
