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
      redirect_to couple_settings_path, notice: t("couple_settings.update.success")
    else
      flash.now[:alert] = t("couple_settings.update.failure")
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    couple = current_user.couples.first

    # 念のためのガード
    if couple.nil?
      redirect_to couples_onboarding_path,
        alert: t("couple_settings.destroy.not_found")
      return
    end

    Couple.transaction do
      couple.destroy!
    end

    redirect_to couples_onboarding_path,
      notice: t("couple_settings.destroy.success")
  end

  private

  def couple_user_params
    params.require(:couple_user).permit(:partner_nickname)
  end
end
