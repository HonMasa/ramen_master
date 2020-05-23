FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'testuser' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }

    # 無効になっている
    trait :invalid do
      email { nil }
    end

    # ゲストユーザー
    trait :guest do
      name { 'ゲスト' }
      email { 'guest@example.com' }
    end
  end
end
