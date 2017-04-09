class AddPayloadToSavedThings < ActiveRecord::Migration[5.0]
  def change
    add_column :saved_things, :payload, :json

    ["subreddit", "kind"].each do |column|
      remove_column :saved_things, column, :string
    end

    ["body", "link_id", "link_title", "link_url", "permalink"].each do |column|
      remove_column :saved_things, column, :text
    end
  end
end
