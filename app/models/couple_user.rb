class CoupleUser < ApplicationRecord
  belongs_to :couple
  belongs_to :user

  validates :partner_nickname, length: { maximum: 50 }, allow_nil: true

  private

  def partner
    couple.couple_users
          .map(&:user)
          .find { |u| u != user }
  end
end
