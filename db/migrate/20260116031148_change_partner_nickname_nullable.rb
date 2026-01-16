class ChangePartnerNicknameNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :couple_users, :partner_nickname, true
  end
end
