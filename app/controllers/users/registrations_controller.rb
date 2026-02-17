class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  # メールアドレス変更専用
  def edit_email
    self.resource = current_user
  end
end
