class ThanksController < ApplicationController
  before_action :authenticate_user!

  def index
    # @received_thanks = Thanks.where(receiver: current_user).order(created_at: :desc)
  end

  def new
    @thanks = Thank.new
  end

  def create
    @thanks = Thank.new
    @thanks.sender = current_user
    @thanks.receiver = partner_user

    if @thanks.save
      redirect_to thanks_path, notice: t("thanks.create.success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def partner_user
    current_user.partner
  end
end
