class CreateMoods < ActiveRecord::Migration[8.1]
  def change
    create_table :moods do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :level, null: false
      t.date :recorded_on, null: false

      t.timestamps
    end

    add_index :moods, [ :user_id, :recorded_on ], unique: true
  end
end
