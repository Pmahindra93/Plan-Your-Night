class AddCategoryToNights < ActiveRecord::Migration[5.2]
  def change
    add_column :nights, :category, :string
  end
end
