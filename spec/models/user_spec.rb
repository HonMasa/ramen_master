require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(
      name: "tester",
      email: "tester@example.com",
      password: "password"
    )
  end
  
  
  #名前、メール、パスワードがあれば有効な状態であること
  it "is valid with a name, email, and password" do
    expect(@user).to be_valid
  end

  #名前がなければ無効な状態であること
  it "is invalid without a name" do
    @user.name = nil
    expect(@user).to be_invalid
  end
  #メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    @user.email = nil
    expect(@user).to be_invalid
  end
  #重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    user2 = User.new(
      name: "tester2",
      email: "tester@example.com",
      password: "password2"
    )
    expect(user2).to be_invalid
  end
  #長すぎるプロフィール文なら無効な状態であること
  it "is invalid with a too long profile" do
    @user.profile = "a" * 201
    expect(@user).to be_invalid
  end
end
