class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :couple_users, dependent: :destroy
  has_many :couples, through: :couple_users
  has_many :invitations, foreign_key: :inviter_id, dependent: :destroy
  has_many :moods, dependent: :destroy

  def partner
    return nil if couples.blank?

    couples.first
           .users
           .where.not(id: id)
           .first
  end
end
