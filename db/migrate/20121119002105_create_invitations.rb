class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :itinerary_id
      t.string :email
      t.string :guid
      t.boolean :accepted

      t.timestamps
    end
  end
end
