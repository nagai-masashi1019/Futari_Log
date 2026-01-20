class MoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @week_dates = (Date.current - 6.days..Date.current).to_a.reverse

    moods = current_user.moods.where(recorded_on: @week_dates).index_by(&:recorded_on)

    @weekly_moods = @week_dates.map do |date|
      [ date, moods[date]&.level || "neutral" ]
    end
  end

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
