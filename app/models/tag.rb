class Tag < ApplicationRecord
  has_many :thanks, dependent: :restrict_with_exception
  has_many :user_hidden_tags, dependent: :destroy
  belongs_to :created_by_user, class_name: "User", optional: true

  validates :name, presence: true, uniqueness: true
  validates :name, uniqueness: { scope: :created_by_user_id }

  # ありがとう作成画面用（非表示タグ除外）
  scope :visible_for, ->(user) {
    where(created_by_user_id: [ nil, user.id ])
      .where.not(id: user.user_hidden_tags.select(:tag_id))
  }

  # タグ管理画面用（表示・非表示含めて全部）
  scope :for_user, ->(user) {
    where(created_by_user_id: [ nil, user.id ])
  }

  DEFAULT_TAGS = [
    "掃除🧹",
    "洗濯🧺",
    "ご飯🍚",
    "洗い物🍴",
    "ゴミ出し🗑️",
    "気遣い😌",
    "助けてくれた🙏",
    "一緒にいて楽しかった🥰",
    "サプライズ🎁",
    "その他🫡"
  ].freeze

  # デフォルトタグが存在しなければ作成する
  def self.ensure_defaults!
    DEFAULT_TAGS.each do |name|
      find_or_create_by!(name: name)
    end
  end
end
