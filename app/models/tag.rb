class Tag < ApplicationRecord
  has_many :thanks, dependent: :restrict_with_exception

  validates :name, presence: true
end
