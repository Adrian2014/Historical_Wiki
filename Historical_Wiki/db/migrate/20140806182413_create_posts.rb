class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.string :post_title
      t.string :post_text
      t.string :post_date

      t.timestamps
    end
  end
end
