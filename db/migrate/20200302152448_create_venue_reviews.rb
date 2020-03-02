class CreateVenueReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_reviews do |t|
      t.references :user, foreign_key: true
      t.references :venue, foreign_key: true
      t.text :content
      t.integer :rating

      t.timestamps
    end
  end
end
