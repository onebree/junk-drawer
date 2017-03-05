class CreateSavedThings < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_things do |t|
      # All saved things
      t.string :type
      t.string :reddit_id
      t.string :subreddit

      # Comments only
      t.text :body

      # For comments and links (without prefix)
      t.text :link_id
      t.text :link_title
      t.text :link_url

      # Links only
      t.text :permalink

      t.timestamps
    end
  end
end
