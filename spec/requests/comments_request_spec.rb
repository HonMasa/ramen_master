require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe '#create' do
    # 認証済のユーザーとして
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      # 有効な属性値の場合
      context 'with valid attributes' do
        # コメントを追加できること
        it 'adds a comment' do
          comment_params = FactoryBot.attributes_for(:comment, post: @post, user: @user)
          sign_in @user
          expect { post "/posts/#{@post.id}/comments", params: { comment: comment_params } }.to change(@post.comments, :count).by(1)
        end
      end

      # 無効な属性値の場合
      context 'with invalid attributes' do
        # コメントを追加できないこと
        it 'does not add a comment' do
          comment_params = FactoryBot.attributes_for(:comment, :invalid)
          sign_in @user
          expect { post "/posts/#{@post.id}/comments", params: { comment: comment_params } }.to_not change(@post.comments, :count)
        end
      end
    end

    # ログインしないで
    context 'not signed in' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        comment_params = FactoryBot.attributes_for(:comment)
        post "/posts/#{@post.id}/comments", params: { comment: comment_params }
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        comment_params = FactoryBot.attributes_for(:comment)
        post "/posts/#{@post.id}/comments", params: { comment: comment_params }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    # 認可されたユーザーとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: @user)
        @comment = FactoryBot.create(:comment, post: @post, user: @user)
      end

      # 投稿を削除できること
      it 'deletes a comment' do
        sign_in @user
        expect { delete "/posts/#{@post.id}/comments/#{@comment.id}" }.to change(@post.comments, :count).by(-1)
      end
    end

    # ログインしないで
    context 'not sined in' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: @user)
        @comment = FactoryBot.create(:comment, post: @post, user: @user)
      end
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        delete "/posts/#{@post.id}/comments/#{@comment.id}"
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        delete "/posts/#{@post.id}/comments/#{@comment.id}"
        expect(response).to redirect_to '/users/sign_in'
      end

      # コメントを削除できないこと
      it 'does not delete the post' do
        expect { delete "/posts/#{@post.id}/comments/#{@comment.id}" }.to_not change(@post.comments, :count)
      end
    end
  end
end
