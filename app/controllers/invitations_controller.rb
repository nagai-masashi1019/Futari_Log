class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_has_no_couple

  def new
    @invitation = current_user.invitations.create!
  end

  def use
    invitation = Invitation.find_by!(code: params[:code])

    unless invitation.available?
      redirect_back fallback_location: couples_onboarding_path, alert: t("invitations.errors.unavailable")
      return
    end

    if invitation.inviter == current_user
      redirect_back fallback_location: couples_onboarding_path, alert: t("invitations.errors.self_use")
      return
    end

    if current_user.couples.exists?
      redirect_to root_path, alert: t("invitations.errors.already_coupled")
      return
    end

    ActiveRecord::Base.transaction do
      couple = Couple.create!

      couple.couple_users.create!(user: invitation.inviter)
      couple.couple_users.create!(user: current_user)

      invitation.update!(
        couple: couple,
        used_at: Time.current
      )
    end

    redirect_to root_path, notice: t("invitations.success")
  end

  private

  def ensure_user_has_no_couple
    return if current_user.couples.empty?

    redirect_to root_path, alert: t("couples.already_coupled")
  end
end
