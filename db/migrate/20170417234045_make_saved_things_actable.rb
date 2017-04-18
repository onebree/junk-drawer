class MakeSavedThingsActable < ActiveRecord::Migration[5.0]
  def up
    drop_table :user_saved_things

    drop_table :saved_things

    create_table :saved_things do |t|
      t.string :name
      t.string :kind
      t.string :reddit_id
      t.string :subreddit
      t.string :author
      t.actable
      t.timestamps
    end

    create_table :user_saved_things do |t|
      t.references :user, foreign_key: true
      t.references :saved_thing, foreign_key: true
      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
