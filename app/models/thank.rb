class Thank < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :tag

  validates :sender, presence: true
  validates :receiver, presence: true
  validates :tag, presence: true
  validate :sender_and_receiver_are_different
  validate :same_couple_only

  scope :this_week, -> {
    where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week)
  }

  after_create :notify_partner
  private

  def sender_and_receiver_are_different
    errors.add(:receiver, :same_as_sender) if sender_id == receiver_id
  end

  def same_couple_only
    return if sender.blank? || receiver.blank?
    return if sender.couples.first == receiver.couples.first

    errors.add(:receiver, :not_same_couple)
  end

  def notify_partner
    return unless receiver.notify_on_thanks?

    Notification.create!(
      recipient: receiver,
      actor: sender,
      action_type: "thanks"
    )
  end
end
