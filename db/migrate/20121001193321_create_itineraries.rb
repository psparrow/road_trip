class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
