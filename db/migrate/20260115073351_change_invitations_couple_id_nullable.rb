class ChangeInvitationsCoupleIdNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :invitations, :couple_id, true
  end
end
