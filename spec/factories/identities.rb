# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    sequence(:email, Time.now.to_i) {|n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end
