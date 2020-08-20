require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  # 新しいユーザーを作成する
  scenario 'creates a new user' do
    visit root_path

    expect do
      click_link '会員登録'
      fill_in '名前', with: 'test_user'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_button '登録'

      expect(page).to have_content 'アカウントを登録しました。'
    end.to change { User.count }.by(1)
  end
end
