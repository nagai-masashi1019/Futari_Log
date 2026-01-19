class Mood < ApplicationRecord
  belongs_to :user

  enum :level, {
    very_good: 5, # 🥰
    good: 4,      # 🙂
    neutral: 3,   # 😐
    bad: 2,       # 😕
    very_bad: 1   # 😢
  }

  validates :level, presence: true
  validates :recorded_on, presence: true
end
