class CreateUserSavedThings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_saved_things do |t|
      t.references :user, foreign_key: true
      t.references :saved_thing, foreign_key: true

      t.timestamps
    end
  end
end
