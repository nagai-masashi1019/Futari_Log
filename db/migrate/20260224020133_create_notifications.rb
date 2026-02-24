class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :actor, null: false, foreign_key: { to_table: :users }
      t.string :action_type, null: false
      t.boolean :read, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :read
  end
end
