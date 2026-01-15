class Couples::OnboardingController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_already_coupled

  def choice
  end

  private

  def redirect_if_already_coupled
    return if current_user.couples.empty?

    redirect_to root_path, alert: t("couples.already_coupled")
  end
end
