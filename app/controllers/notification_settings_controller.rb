class NotificationSettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(notification_params)
      redirect_to edit_notification_settings_path, notice: t("notification_settings.update.success")
    else
      render :edit
    end
  end

  private

  def notification_params
    params.require(:user).permit(:notify_on_mood, :notify_on_thanks)
  end
end
