FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'testuser' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
  end
end
