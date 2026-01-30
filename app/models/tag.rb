class Tag < ApplicationRecord
  has_many :thanks, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true

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
