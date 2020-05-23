require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe '#show' do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post)
    end

    # 正常にレスポンスを返すこと
    it 'responds successfully' do
      get "/posts/#{@post.id}"
      expect(response).to be_successful
    end

    # 200レスポンスを返すこと
    it 'returns a 200 response' do
      get "/posts/#{@post.id}"
      expect(response).to have_http_status '200'
    end
  end

  describe '#new' do
    # ログイン済のユーザーとして
    context 'as sined in user' do
      before do
        @user = FactoryBot.create(:user)
      end

      # 正常にレスポンスを返すこと
      it 'responds successfully' do
        sign_in @user
        get '/posts/new'
        expect(response).to be_successful
      end

      # 200レスポンスを返すこと
      it 'returns a 200 response' do
        sign_in @user
        get '/posts/new'
        expect(response).to have_http_status '200'
      end
    end

    # ログインしないで
    context 'not signed in user' do
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        get '/posts/new'
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        get '/posts/new'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#edit' do
    # 認可されたユーザーとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: @user)
      end

      # 正常にレスポンスを返すこと
      it 'responds successfully' do
        sign_in @user
        get "/posts/#{@post.id}/edit"
        expect(response).to be_successful
      end
    end

    # 認可されていないユーザーとして
    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: other_user)
      end

      # ダッシュボードにリダイレクトすること
      it 'redirects to root_path' do
        sign_in @user
        get "/posts/#{@post.id}/edit"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#create' do
    # 認証済のユーザーとして
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end

      # 有効な属性値の場合
      context 'with valid attributes' do
        # 投稿を追加できること
        it 'adds a post' do
          post_params = FactoryBot.attributes_for(:post)
          sign_in @user
          expect { post '/posts', params: { post: post_params } }.to change(@user.posts, :count).by(1)
        end
      end

      # 無効な属性値の場合
      context 'with invalid attributes' do
        # 投稿を追加できないこと
        it 'does not add a post' do
          post_params = FactoryBot.attributes_for(:post, :invalid)
          sign_in @user
          expect { post '/posts', params: { post: post_params } }.to_not change(@user.posts, :count)
        end
      end
    end

    # ログインしないで
    context 'not signed in' do
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        post_params = FactoryBot.attributes_for(:post)
        post '/posts', params: { post: post_params }
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        post_params = FactoryBot.attributes_for(:post)
        post '/posts', params: { post: post_params }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#update' do
    # 認可されたユーザーとして
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: @user)
      end

      # 投稿を更新できる
      it 'updates a post' do
        post_params = FactoryBot.attributes_for(:post, ramen_name: 'New Post Name')
        sign_in @user
        patch "/posts/#{@post.id}", params: { post: post_params }
        expect(@post.reload.ramen_name).to eq 'New Post Name'
      end
    end

    # 認可されていないユーザーとして
    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: other_user, ramen_name: 'Same Old Name')
      end

      # プロジェクトを更新できないこと
      it 'redirects to the dashboard' do
        post_params = FactoryBot.attributes_for(:post, ramen_name: 'New Post Name')
        sign_in @user
        patch "/posts/#{@post.id}", params: { post: post_params }
        expect(@post.reload.ramen_name).to eq 'Same Old Name'
      end

      # ダッシュボードヘリダイレクトすること
      it 'redirects to root_path' do
        post_params = FactoryBot.attributes_for(:post, ramen_name: 'New Post Name')
        sign_in @user
        patch "/posts/#{@post.id}", params: { post: post_params }
        expect(response).to redirect_to root_path
      end
    end

    # ログインしないで
    context 'not sined in' do
      before do
        @post = FactoryBot.create(:post)
      end
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        post_params = FactoryBot.attributes_for(:post)
        patch "/posts/#{@post.id}", params: { post: post_params }
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        post_params = FactoryBot.attributes_for(:post)
        patch "/posts/#{@post.id}", params: { post: post_params }
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
      end

      # 投稿を削除できること
      it 'deletes a post' do
        sign_in @user
        expect { delete "/posts/#{@post.id}" }.to change(@user.posts, :count).by(-1)
      end
    end

    # 認可されていないユーザーとして
    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: other_user)
      end

      # 投稿を削除できないこと
      it 'does not delete the post' do
        sign_in @user
        expect { delete "/posts/#{@post.id}" }.to_not change(@user.posts, :count)
      end

      # ダッシュボードヘリダイレクトすること
      it 'redirects to root_path' do
        sign_in @user
        delete "/posts/#{@post.id}"
        expect(response).to redirect_to root_path
      end
    end

    # ログインしないで
    context 'not sined in' do
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, owner: @user)
      end
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        delete "/posts/#{@post.id}"
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        delete "/posts/#{@post.id}"
        expect(response).to redirect_to '/users/sign_in'
      end

      # 投稿を削除できないこと
      it 'does not delete the post' do
        expect { delete "/posts/#{@post.id}" }.to_not change(@user.posts, :count)
      end
    end
  end
end
