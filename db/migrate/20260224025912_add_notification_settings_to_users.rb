class AddNotificationSettingsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :notify_on_mood, :boolean, default: true, null: false
    add_column :users, :notify_on_thanks, :boolean, default: true, null: false
  end
end
