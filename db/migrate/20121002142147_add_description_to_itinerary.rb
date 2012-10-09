class AddDescriptionToItinerary < ActiveRecord::Migration
  def change
    add_column :itineraries, :description, :text
  end
end
