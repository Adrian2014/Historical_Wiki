class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|

      t.integer user_id
      t.integer ratings
      t.integer starable_id
      t.string starable_type



      t.timestamps
    end
  end
end
