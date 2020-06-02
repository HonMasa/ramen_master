class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[edit update destroy]

  def update
    super
  end

  def destroy
    super
  end

  def edit
    super
  end

  private

  def check_guest
    redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。' if current_user.email == 'guest@example.com'
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
