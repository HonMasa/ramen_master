require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let!(:post) { FactoryBot.create(:post) }

  # 名前、文章、ユーザーidがあれば有効な状態であること
  it 'is valid with a ramen_name, content, and user_id' do
    expect(post).to be_valid
  end

  # 名前がなければ無効な状態であること
  it 'is invalid without a ramen_name' do
    post.ramen_name = nil
    expect(post).to be_invalid
  end

  # 文章がなければ無効な状態であること
  it 'is invalid without a content' do
    post.content = nil
    expect(post).to be_invalid
  end

  # ユーザーidがなければ無効な状態であること
  it 'is invalid without a user_id' do
    post.user_id = nil
    expect(post).to be_invalid
  end

  # 文章が長すぎる場合は無効な状態であること
  it 'is invalid with a too long content' do
    post.content = 'a' * 251
    expect(post).to be_invalid
  end

  # likeメソッドでいいねが１増える
  it 'increase likes' do
    post.like(user)
    expect(Like.count).to eq 1
  end

  # dislikeメソッドでいいねが１減る
  # it 'decrease likes' do
  #   user.likes.create(
  #     post_id: 1
  #   )
  #   post.dislike(user)
  #   expect(Like.count).to eq 0
  # end
end
