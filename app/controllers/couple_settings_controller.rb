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

  def destroy
    couple = current_user.couples.first

    # 念のためのガード
    if couple.nil?
      redirect_to couples_onboarding_path,
        alert: "カップルが存在しません"
      return
    end

    Couple.transaction do
      couple.destroy!
    end

    redirect_to couples_onboarding_path,
      notice: "カップル設定を解除しました"
  end

  private

  def couple_user_params
    params.require(:couple_user).permit(:partner_nickname)
  end
end
