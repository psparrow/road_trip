class AddPositionToStops < ActiveRecord::Migration
  def change
    add_column :stops, :position, :integer, default: 0
  end
end
