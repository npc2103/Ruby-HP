class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :shop_id
      t.references :user, null: false, foreign_key: true
      t.integer :good
      t.integer :bad

      t.timestamps
    end
  end
end
