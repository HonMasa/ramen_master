require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  describe '#create' do
    # 認証済のユーザーとして
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      # いいねできること
      it 'adds a like' do
        sign_in @user
        expect { @post.like(@user) }.to change { Like.count }.by(1)
      end
    end
  end
  describe '#create' do
    # 認証済のユーザーとして
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      # いいねを削除できること
      it 'dislike' do
        sign_in @user
        @post.like(@user)
        expect { @post.dislike(@user) }.to change { Like.count }.by(-1)
      end
    end
  end
end
