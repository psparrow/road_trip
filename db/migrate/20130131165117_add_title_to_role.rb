class AddTitleToRole < ActiveRecord::Migration
  def change
    add_column :roles, :title, :string
  end
end
