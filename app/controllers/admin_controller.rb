class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @users_count = User.count
    @moods_count = Mood.count
    @thanks_count = Thank.count
  end

  def users
    @users = User.order(created_at: :desc)
  end

  def moods
    @moods = Mood.includes(:user).order(recorded_on: :desc)
  end

  def thanks
    @thanks = Thank.includes(:sender, :receiver).order(created_at: :desc)
  end

  def destroy_user
    user = User.find(params[:id])
    user.destroy
    redirect_to "/admin/users", notice: "ユーザーを削除しました"
  end

  private

  def admin_only
    redirect_to root_path unless current_user.email == "m20007755@docomo.ne.jp"
  end
end
