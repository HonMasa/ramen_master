require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #show' do
      let(:user) { FactoryBot.create(:user)}
    
    # 正常にレスポンスを返すこと
    it 'responds successfully' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end
    # 200レスポンスを返すこと
    it 'returns a 200 response' do
      get "/users/#{user.id}"
      expect(response).to have_http_status '200'
    end
  end

  describe '#edit' do
    # 認可されたユーザーとして
    context 'as an authorized user' do
      let(:user) { FactoryBot.create(:user)}

      # 正常にレスポンスを返すこと
      it 'responds successfully' do
        sign_in user
        get '/users/edit'
        expect(response).to be_successful
      end
    end

    # ゲストユーザーとして
    context 'as an guest user' do
      before do
        @user = FactoryBot.create(:user, :guest)
      end

      # ダッシュボードにリダイレクトする
      it 'responds successfully' do
        sign_in @user
        get '/users/edit'
        expect(response).to redirect_to root_path
      end
    end
  end

  # 会員登録画面
  describe '#new' do
    # ログインしていない状態で
    context 'as a not authorized user' do
      # 正常にレスポンスを返すこと
      it 'responds successfully' do
        get '/users/sign_up'
        expect(response).to be_successful
      end
    end

    # ログインして
    context 'sined in' do
      let(:user) { FactoryBot.create(:user)}

      # ダッシュボードにリダイレクトする
      it 'responds successfully' do
        sign_in user
        get '/users/sign_up'
        expect(response).to redirect_to root_path
      end
    end
  end

  # 新規会員登録
  describe '#create' do
    # ログインしないで
    context 'not signed in' do
      # 有効な属性値の場合
      context 'with valid attributes' do
        # 投稿を追加できること
        it 'adds a user' do
          user_params = FactoryBot.attributes_for(:user)
          expect { post '/users', params: { user: user_params } }.to change { User.count }.by(1)
        end
      end

      # 無効な属性値の場合
      context 'with invalid attributes' do
        # 投稿を追加できないこと
        it 'does not add a post' do
          user_params = FactoryBot.attributes_for(:user, :invalid)
          expect { post '/users', params: { user: user_params } }.to_not change { User.count }
        end
      end
    end

    # ログインした状態で
    context 'signed in' do
      let(:user) { FactoryBot.create(:user)}
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        user_params = FactoryBot.attributes_for(:user)
        sign_in user
        post '/users', params: { user: user_params }
        expect(response).to have_http_status '302'
      end

      # ダッシュボードヘリダイレクトすること
      it 'redirects to root_path' do
        user_params = FactoryBot.attributes_for(:user)
        sign_in user
        post '/users', params: { user: user_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#update' do
    # 認可されたユーザーとして
    context 'as an authorized user' do
      let(:user) { FactoryBot.create(:user)}

      # 投稿を更新できる
      it 'updates a user' do
        user_params = FactoryBot.attributes_for(:user, name: 'New Name')
        sign_in user
        patch '/users', params: { user: user_params }
        expect(user.reload.name).to eq 'New Name'
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      before do
        @user = FactoryBot.create(:user, :guest)
      end

      # ユーザーを更新できないこと
      it 'redirects to the dashboard' do
        user_params = FactoryBot.attributes_for(:user, name: 'New Name')
        sign_in @user
        patch '/users', params: { user: user_params }
        expect(@user.reload.name).to eq 'ゲスト'
      end

      # ダッシュボードヘリダイレクトすること
      it 'redirects to root_path' do
        user_params = FactoryBot.attributes_for(:user, name: 'New Name')
        sign_in @user
        patch '/users', params: { user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    # ログインしないで
    context 'not sined in' do
      # 302レスポンスを返すこと
      it 'returns a 302 response' do
        user_params = FactoryBot.attributes_for(:user, name: 'New Name')
        patch '/users', params: { user: user_params }
        expect(response).to have_http_status '302'
      end

      # サインイン画面にリダイレクトすること
      it 'redirects to sign-in page' do
        user_params = FactoryBot.attributes_for(:user, name: 'New Name')
        patch '/users', params: { user: user_params }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  # ユーザー削除
  describe '#destroy' do
    # 認可されたユーザーとして
    context 'as an authorized user' do
      let(:user) { FactoryBot.create(:user)}

      # ユーザーを削除できること
      it 'deletes a user' do
        sign_in user
        expect { delete '/users' }.to change { User.count }.by(-1)
      end
    end

    # ゲストユーザーとして
    context 'as a guest user' do
      before do
        @user = FactoryBot.create(:user, :guest)
      end

      # 投稿を削除できないこと
      it 'does not delete the user' do
        sign_in @user
        expect { delete '/users' }.to_not change { User.count }
      end

      # ダッシュボードヘリダイレクトすること
      it 'redirects to root_path' do
        sign_in @user
        delete '/users'
        expect(response).to redirect_to root_path
      end
    end
  end
end
