class HomeController < ApplicationController
  def index
    return unless user_signed_in?

    @today_mood = current_user.moods.find_by(recorded_on: Date.current)

    @week_dates = (Date.current - 6.days..Date.current).to_a

    # === 自分のごきげん ===
    moods = current_user.moods
              .where(recorded_on: @week_dates)
              .to_a
              .index_by { |m| m.recorded_on.to_date }

    @weekly_scores = @week_dates.map do |date|
      moods[date]&.score || 50
    end

    @weekly_average = (@weekly_scores.sum / 7.0).round
    @weekly_level = Mood.level_from_average(@weekly_average)
    @weekly_received_thanks_count =
      Thank.this_week.where(receiver: current_user).count
  end
end
