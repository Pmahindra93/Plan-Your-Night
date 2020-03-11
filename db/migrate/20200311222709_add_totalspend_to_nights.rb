class AddTotalspendToNights < ActiveRecord::Migration[5.2]
  def change
    add_column :nights, :total_spend, :integer, default: 0
  end
end
