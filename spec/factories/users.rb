# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email, Time.now.to_i) {|n| "person#{n}@example.com" }
  end
end
