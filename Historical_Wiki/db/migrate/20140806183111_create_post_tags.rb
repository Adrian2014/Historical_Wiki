class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|

      t.timestamps
    end
  end
end
