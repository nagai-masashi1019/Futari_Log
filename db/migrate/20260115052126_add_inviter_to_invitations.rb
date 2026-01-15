class AddInviterToInvitations < ActiveRecord::Migration[8.1]
  def change
    add_reference :invitations, :inviter, null: false, foreign_key: { to_table: :users }
  end
end
