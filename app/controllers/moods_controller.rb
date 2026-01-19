class MoodsController < ApplicationController
  before_action :authenticate_user!

  def create
    mood = current_user.moods.new(
      level: params[:level],
      recorded_on: Date.current
    )

    if mood.save
      redirect_back fallback_location: root_path, notice: t("moods.create.success")
    else
      redirect_back fallback_location: root_path, alert: t("moods.create.already_recorded")
    end
  end
end
