class AddLocationsToNights < ActiveRecord::Migration[5.2]
  def change
    add_column :nights, :location, :string
  end
end
