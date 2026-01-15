class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: "User"
  belongs_to :couple, optional: true

  validates :code, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validates :inviter, presence: true

  before_validation :generate_code, on: :create
  before_validation :set_expiration, on: :create

  # 使用済み？
  def used?
    used_at.present?
  end

  # 有効期限切れ？
  def expired?
    expires_at < Time.current
  end

  # 使用可能？
  def available?
    !used? && !expired?
  end

  private

  def generate_code
    return if code.present?

    loop do
      self.code = SecureRandom.urlsafe_base64(8)
      break unless Invitation.exists?(code: code)
    end
  end

  def set_expiration
    self.expires_at ||= 24.hours.from_now
  end
end
