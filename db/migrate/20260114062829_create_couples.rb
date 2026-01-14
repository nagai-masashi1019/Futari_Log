class CreateCouples < ActiveRecord::Migration[8.1]
  def change
    create_table :couples do |t|
      t.timestamps
    end
  end
end
