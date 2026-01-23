class ThanksController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_thanks = Thank.where(receiver: current_user).includes(:tag, :sender).order(created_at: :desc)
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
