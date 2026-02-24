class Mood < ApplicationRecord
  belongs_to :user

  enum :level, {
    very_good: 5, # 🥰
    good: 4,      # 🙂
    neutral: 3,   # 😐
    bad: 2,       # 😕
    very_bad: 1   # 😢
  }

  SCORE_MAP = {
    very_good: 100,
    good: 75,
    neutral: 50,
    bad: 25,
    very_bad: 0
  }

  LEVEL_BY_SCORE = [
    { min: 80, level: "very_good" },
    { min: 60, level: "good" },
    { min: 40, level: "neutral" },
    { min: 20, level: "bad" },
    { min: 0,  level: "very_bad" }
  ]

  def self.level_from_average(score)
    LEVEL_BY_SCORE.find { |rule| score >= rule[:min] }[:level]
  end

  def score
    SCORE_MAP[level.to_sym]
  end

  validates :level, presence: true
  validates :recorded_on, presence: true

  after_create :notify_partner
  private

  def notify_partner
    partner = user.couple_users.first&.couple&.users&.where.not(id: user.id)&.first
    return unless partner&.notify_on_mood?

    Notification.create!(
      recipient: partner,
      actor: user,
      action_type: "mood"
    )
  end
end
