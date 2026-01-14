class CreateCoupleUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :couple_users do |t|
      t.references :couple, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :partner_nickname, null: false

      t.timestamps
    end
    add_index :couple_users, [:couple_id, :user_id], unique: true
  end
end
