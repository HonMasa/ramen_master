require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:post) { FactoryBot.create(:post) }

  let(:comment) { FactoryBot.create(:comment) }

  # ファクトリで関連するデータを生成する
  it 'generates associated data from a factory' do
    puts "This comment's post is #{comment.post.inspect}"
    puts "This comment's user is #{comment.user.inspect}"
  end

  # 文章、ポストid、ユーザーidがあれば有効な状態であること
  it 'is valid with a content, post_id, and user_id' do
    expect(comment).to be_valid
  end

  # post_idがなければ無効な状態であること
  it 'is invalid without a post_id' do
    comment.post_id = nil
    expect(comment).to be_invalid
  end

  # 文章がなければ無効な状態であること
  it 'is invalid without a content' do
    comment.content = nil
    expect(comment).to be_invalid
  end

  # ユーザーidがなければ無効な状態であること
  it 'is invalid without a user_id' do
    comment.user_id = nil
    expect(comment).to be_invalid
  end

  # 文章が長すぎる場合は無効な状態であること
  it 'is invalid with a too long content' do
    comment.content = 'a' * 141
    expect(comment).to be_invalid
  end
end
