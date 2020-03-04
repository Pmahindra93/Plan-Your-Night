class AddBudgetToNights < ActiveRecord::Migration[5.2]
  def change
    add_column :nights, :budget, :string
  end
end
