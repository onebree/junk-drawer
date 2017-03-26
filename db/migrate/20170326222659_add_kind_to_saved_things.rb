class AddKindToSavedThings < ActiveRecord::Migration[5.0]
  def change
    add_column :saved_things, :kind, :string
  end
end
