class ChangeTypeToVenueTypeInVenues < ActiveRecord::Migration[5.2]
  def change
    rename_column :venues, :type, :venue_type
  end
end
