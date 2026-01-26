class ThanksController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_thanks = Thank.where(receiver: current_user).includes(:tag, :sender).order(created_at: :desc)
    # 今週贈ったありがとう
    @weekly_sent_thanks_count = Thank.this_week.where(sender: current_user).count
    # 過去4週間（月曜始まり）
    start_date = 4.weeks.ago.beginning_of_week
    end_date   = Time.zone.now.end_of_week

    raw_data = Thank.where(receiver: current_user, sender: current_user.partner, created_at: start_date..end_date)
           .group(Arel.sql("DATE_TRUNC('week', created_at)"))
           .order(Arel.sql("DATE_TRUNC('week', created_at)"))
           .count
    # 表示用に整形（空週も0で埋める）
    @weekly_received_thanks = []

    4.times do |i|
      week_start = (3 - i).weeks.ago.beginning_of_week
      week_end   = week_start.end_of_week

      count = raw_data[week_start.beginning_of_day] || 0

      @weekly_received_thanks << {
        label: "#{week_start.strftime('%-m/%-d')}〜#{week_end.strftime('%-m/%-d')}",
        count: count
      }
    end
  end

  def new
    @thanks = Thank.new
    @tags = Tag.all
  end

  def create
    @thanks = Thank.new(thank_params)
    @thanks.sender = current_user
    @thanks.receiver = partner_user
    @tags = Tag.all

    if @thanks.save
      redirect_to thanks_path, notice: t("thanks.create.success")
    else
      @tags = Tag.all
      flash.now[:alert] = t("thanks.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def thank_params
    params.require(:thank).permit(:tag_id)
  end

  def partner_user
    current_user.partner
  end
end
