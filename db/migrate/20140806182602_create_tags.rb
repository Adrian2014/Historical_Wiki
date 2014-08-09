class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.string :tag_text
      t.string :tag_slug

      t.timestamps
    end

    add_index :tags, :tag_slug, unique: true
  end
end
