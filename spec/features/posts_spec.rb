require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  pending "add some scenarios (or delete) #{__FILE__}"

  # ユーザーは新しい投稿を作成する
  scenario 'user creates a new project' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    expect do
      click_link '新規投稿'
      fill_in 'ラーメン名', with: 'ramen_name'
      fill_in 'ラーメンの種類', with: '醤油'
      fill_in '店名', with: 'ramen_shop'
      fill_in '評価', with: '2'
      fill_in '都道府県', with: '13'
      fill_in '住所', with: '東京'
      click_button '投稿'

      expect(page).to have_content '記事を投稿しました！'
      expect(page).to have_content 'ramen_name'
    end.to change(user.posts, :count).by(1)
  end
end
