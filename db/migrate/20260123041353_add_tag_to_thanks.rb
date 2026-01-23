class AddTagToThanks < ActiveRecord::Migration[8.1]
  def change
    add_reference :thanks, :tag, foreign_key: true
  end
end
