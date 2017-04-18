class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.text :title
      t.text :url
      t.text :permalink
      t.text :selftext_html
      t.text :thumbnail
      t.json :media

      t.timestamps
    end
  end
end
