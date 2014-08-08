class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.string :post_title
      t.text :post_text
      t.date :post_date

      t.timestamps
    end

    add_index :posts, :post_date
  end
end
