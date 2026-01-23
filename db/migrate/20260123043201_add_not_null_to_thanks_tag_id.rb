class AddNotNullToThanksTagId < ActiveRecord::Migration[8.1]
  def change
    change_column_null :thanks, :tag_id, false
  end
end
