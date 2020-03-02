class CreateNightVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :night_venues do |t|
      t.references :venue, foreign_key: true
      t.references :night, foreign_key: true

      t.timestamps
    end
  end
end
