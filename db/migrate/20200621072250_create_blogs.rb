class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :author
      t.string :title
      t.string :details
      t.text :body
      t.string :other_tags
      t.string :search_tag

      t.timestamps
    end
  end
end
