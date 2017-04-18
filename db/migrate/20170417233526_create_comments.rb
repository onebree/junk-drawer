class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body_html
      t.text :link_author
      t.text :link_id
      t.text :link_title
      t.text :link_url
    end
  end
end
