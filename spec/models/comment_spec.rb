require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = User.create(
      name: "tester",
      email: "tester@example.com",
      password: "password"
    )
    
    @post = Post.create(
      ramen_name: "ramen",
      content: "test",
      user_id: 1
    )
    
    @comment = Comment.create(
      user_id: 1,
      post_id: 1,
      content: "testtext"
    )
  end
  
  #文章、ポストid、ユーザーidがあれば有効な状態であること
  it "is valid with a content, post_id, and user_id" do
    expect(@comment).to be_valid
  end
  
  #post_idがなければ無効な状態であること
  it "is invalid without a post_id" do
    @comment.post_id = nil
    expect(@comment).to be_invalid
  end
  
  #文章がなければ無効な状態であること
  it "is invalid without a content" do
    @comment.content = nil
    expect(@comment).to be_invalid
  end
  
  #ユーザーidがなければ無効な状態であること
  it "is invalid without a user_id" do
    @comment.user_id = nil
    expect(@comment).to be_invalid
  end
  
  #文章が長すぎる場合は無効な状態であること
  it "is invalid with a too long content" do
    @comment.content = "a" * 141
    expect(@comment).to be_invalid
  end
end
