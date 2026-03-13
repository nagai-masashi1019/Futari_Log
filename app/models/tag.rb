class Tag < ApplicationRecord
  has_many :thanks, dependent: :restrict_with_exception
  has_many :user_hidden_tags, dependent: :destroy
  belongs_to :created_by_user, class_name: "User", optional: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :created_by_user_id }

  # ありがとう作成画面用（非表示タグ除外）
  scope :visible_for, ->(user) {
    where(created_by_user_id: [nil, user.id])
      .where.not(id: user.user_hidden_tags.select(:tag_id))
  }

  # タグ管理画面用（表示・非表示含めて全部）
  scope :for_user, ->(user) {
    where(created_by_user_id: [nil, user.id])
  }

  def self.default_tags
    [
      I18n.t("tags.defaults.cleaning"),
      I18n.t("tags.defaults.laundry"),
      I18n.t("tags.defaults.cooking"),
      I18n.t("tags.defaults.dishes"),
      I18n.t("tags.defaults.trash"),
      I18n.t("tags.defaults.consideration"),
      I18n.t("tags.defaults.helped"),
      I18n.t("tags.defaults.fun_time"),
      I18n.t("tags.defaults.surprise"),
      I18n.t("tags.defaults.other")
    ]
  end

  def self.ensure_defaults!
    default_tags.each do |name|
      find_or_create_by!(name: name)
    end
  end
end