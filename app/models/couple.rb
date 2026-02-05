class Couple < ApplicationRecord
  has_many :couple_users, dependent: :destroy
  has_many :users, through: :couple_users
  has_many :invitations, dependent: :destroy
end
