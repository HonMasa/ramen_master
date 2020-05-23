FactoryBot.define do
  factory :comment do
    content { 'testcomment' }
    association :post
    association :user

    # 無効になっている
    trait :invalid do
      content { nil }
    end
  end
end
