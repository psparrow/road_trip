class AddRoleToContributor < ActiveRecord::Migration
  def change
    add_column :contributors, :role_id, :integer
  end
end
