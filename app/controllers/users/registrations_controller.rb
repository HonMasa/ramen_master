class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update destroy]

  def check_guest
    redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。' if resouce.email == 'guest@example.com'
  end
end
