class DropUserSavedThings < ActiveRecord::Migration[5.0]
  def up
    drop_table :user_saved_things
    add_reference :saved_things, :user
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
