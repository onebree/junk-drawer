class CreateUsersAndSavedThings < ActiveRecord::Migration[5.0]
  def change
    create_table :users_saved_things, :id => false do |t|
      t.belongs_to :user, :index => true
      t.belongs_to :saved_thing, :index => true
    end
  end
end
