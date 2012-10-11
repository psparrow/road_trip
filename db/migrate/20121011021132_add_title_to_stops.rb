class AddTitleToStops < ActiveRecord::Migration
  def change
    add_column :stops, :title, :string
  end
end
