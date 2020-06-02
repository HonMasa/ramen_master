FactoryBot.define do
  factory :post do
    sequence(:ramen_name) { |n| "ramen#{n}" }
    content { 'test content' }
    association :owner
    prefecture_code { 13 }

    # 無効になっている
    trait :invalid do
      ramen_name { nil }
    end
  end
end
