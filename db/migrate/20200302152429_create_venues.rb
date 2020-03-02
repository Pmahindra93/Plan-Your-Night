class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :type
      t.string :category
      t.string :name
      t.string :address
      t.float :longitude
      t.float :latitude
      t.string :opening_hours
      t.string :price_segment
      t.boolean :card_accepted
      t.text :description

      t.timestamps
    end
  end
end
