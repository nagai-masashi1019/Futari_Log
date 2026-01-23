# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Tag.find_or_create_by!(name: "掃除🧹")
Tag.find_or_create_by!(name: "洗濯🧺")
Tag.find_or_create_by!(name: "ご飯🍚")
Tag.find_or_create_by!(name: "洗い物🍴")
Tag.find_or_create_by!(name: "ゴミ出し🗑️")
Tag.find_or_create_by!(name: "気遣い😌")
Tag.find_or_create_by!(name: "助けてくれた🙏")
Tag.find_or_create_by!(name: "一緒にいて楽しかった🥰")
Tag.find_or_create_by!(name: "サプライズ🎁")
Tag.find_or_create_by!(name: "その他🫡")
