class CreateNights < ActiveRecord::Migration[5.2]
  def change
    create_table :nights do |t|
      t.references :user, foreign_key: true
      t.string :total_price_segment

      t.timestamps
    end
  end
end
