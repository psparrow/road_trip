class DropInvitees < ActiveRecord::Migration
  def up
    drop_table :invitees
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
