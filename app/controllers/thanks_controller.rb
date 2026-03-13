class ThanksController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_thanks = Thank
      .where(receiver: current_user)
      .includes(:tag, :sender)
      .order(created_at: :desc)

    # 今週贈ったありがとう
    @weekly_sent_thanks_count =
      Thank.this_week.where(sender: current_user).count

    # 過去4週間（月曜始まり）
    start_date = 4.weeks.ago.beginning_of_week
    end_date   = Time.zone.now.end_of_week

    # DB側は UTC のまま週単位で集計
    raw_data = Thank
      .where(
        receiver: current_user,
        sender: current_user.partner,
        created_at: start_date..end_date
      )
      .group(Arel.sql("DATE_TRUNC('week', created_at)"))
      .count

    # key を Date に正規化する
    normalized_data = raw_data.transform_keys do |time|
      time.to_date
    end

    # 表示用に整形（空週も0で埋める）
    @weekly_received_thanks = []

    4.times do |i|
      week_start = (3 - i).weeks.ago.beginning_of_week.to_date
      week_end   = week_start.end_of_week.to_date

      count = normalized_data[week_start] || 0

      @weekly_received_thanks << {
        label: "#{week_start.strftime('%-m/%-d')}〜#{week_end.strftime('%-m/%-d')}",
        count: count
      }
    end
  end


  def new
    Tag.ensure_defaults!
    @thanks = Thank.new
    @tags = Tag.visible_for(current_user)
  end

  def create
    @thanks = Thank.new(thank_params)
    @thanks.sender = current_user
    @thanks.receiver = partner_user
    @tags = Tag.visible_for(current_user)

    if @thanks.save
      redirect_to thanks_path, notice: t("thanks.create.success")
    else
      @tags = Tag.visible_for(current_user)
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
