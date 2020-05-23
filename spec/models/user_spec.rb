require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前、メール、パスワードがあれば有効な状態であること
  it 'is valid with a name, email, and password' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前がなければ無効な状態であること
  it 'is invalid without a name' do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to be_invalid
  end
  # メールアドレスがなければ無効な状態であること
  it 'is invalid without an email address' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to be_invalid
  end
  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'tester@example.com')
    user = FactoryBot.build(:user, email: 'tester@example.com')
    expect(user).to be_invalid
  end
  # 長すぎるプロフィール文なら無効な状態であること
  it 'is invalid with a too long profile' do
    user = FactoryBot.build(:user, profile: 'a' * 201)
    expect(user).to be_invalid
  end
end
