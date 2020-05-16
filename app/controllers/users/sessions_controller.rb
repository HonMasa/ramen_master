class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end

  def destroy
    super
    flash[:success] = 'ログアウトしました'
  end
end
