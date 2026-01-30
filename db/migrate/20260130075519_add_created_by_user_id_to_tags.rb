class AddCreatedByUserIdToTags < ActiveRecord::Migration[8.1]
  def change
    add_column :tags, :created_by_user_id, :bigint
    add_index  :tags, :created_by_user_id
  end
end
