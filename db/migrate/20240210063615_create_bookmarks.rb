class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id, null: false
      t.string :shop_id, null: false
      t.string :shop_name, null: false

      t.timestamps
    end
    add_index :bookmarks, :user_id
    add_index :bookmarks, :shop_id
  end
end
