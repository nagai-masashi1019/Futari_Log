class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(account_params)
      redirect_to account_path, notice: t("accounts.update.success")
    else
      flash.now[:alert] = t("accounts.update.failure")
      render :show, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:user).permit(:nickname)
    # 今後 :email をここに足すだけでOK
  end
end
