class HomeController < ApplicationController
  def index
    return unless user_signed_in?

    @today_mood = current_user.moods.find_by(recorded_on: Date.current)
  end
end
