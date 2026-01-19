class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_has_no_couple

  def new
    @invitation = current_user.invitations.create!
  end

  def use_form
  end

  def use
    invitation = Invitation.find_by!(code: params[:code])

    unless invitation.available?
      redirect_back fallback_location: couples_onboarding_path, alert: t("invitations.use.errors.unavailable")
      return
    end

    if invitation.inviter == current_user
      redirect_back fallback_location: couples_onboarding_path, alert: t("invitations.use.errors.self_use")
      return
    end

    if current_user.couples.exists?
      redirect_to root_path, alert: t("invitations.use.errors.already_coupled")
      return
    end

    ActiveRecord::Base.transaction do
      couple = Couple.create!

      inviter_cu = couple.couple_users.create!(user: invitation.inviter)
      current_cu = couple.couple_users.create!(user: current_user)

      inviter_cu.update!(
        partner_nickname: current_user.nickname
      )

      current_cu.update!(
        partner_nickname: invitation.inviter.nickname
      )

      invitation.update!(
        couple: couple,
        used_at: Time.current
      )
    end

    redirect_to root_path, notice: t("invitations.use.success")
  end

  private

  def ensure_user_has_no_couple
    return if current_user.couples.empty?

    redirect_to root_path, alert: t("couples.already_coupled")
  end
end
