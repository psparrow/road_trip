class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :user_id
      t.integer :itinerary_id
      t.text :description
      t.string :url
      t.string :city
      t.string :state
      t.string :zip_code
      t.datetime :date

      t.timestamps
    end
  end
end
