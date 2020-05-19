require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = User.create(
      name: "tester",
      email: "tester@example.com",
      password: "password"
    )
    
    @other_user = User.create(
      name: "testuser2",
      email: "testuser2@example.com",
      password: "password2"
    )
    
    @post = Post.create(
      ramen_name: "ramen",
      content: "test",
      user_id: 1
    )
  end
  
  #ユーザー単位で重複したいいねはできない
  it "dose not allow duplicate like per user" do
    @user.likes.create(
      post_id: 1
    )
    
    new_like = @user.likes.build(
      post_id: 1
    )
    
    expect(new_like).to be_invalid
  end
  
  #別ユーザーはいいねできる
  it "allow other users to like" do
    @user.likes.create(
      post_id: 1
    )
    
    new_like = @other_user.likes.build(
      post_id: 1
    )
    
    expect(new_like).to be_valid
  end
  
  
end
