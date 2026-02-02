# app/controllers/couple_settings_controller.rb
class CoupleSettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @couple_user = current_user.couple_users.first
    @partner = current_user.partner
  end

  def update
    @couple_user = current_user.couple_users.first
    @partner = current_user.partner

    if @couple_user.update(couple_user_params)
      redirect_to couple_settings_path, notice: "パートナーの表示名を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :show, status: :unprocessable_entity
    end
  end

  private

  def couple_user_params
    params.require(:couple_user).permit(:partner_nickname)
  end
end
