require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:other_user) { FactoryBot.create(:user) }

  let!(:post) { FactoryBot.create(:post) }

  # ユーザー単位で重複したいいねはできない
  it 'dose not allow duplicate like per user' do
    user.likes.create(
      post_id: 1
    )

    new_like = user.likes.build(
      post_id: 1
    )

    expect(new_like).to be_invalid
  end

  # 別ユーザーはいいねできる
  # it 'allow other users to like' do
  #   user.likes.create(
  #     post_id: 1
  #   )

  #   new_like = other_user.likes.build(
  #     post_id: 1
  #   )

  #   expect(new_like).to be_valid
  # end
end
