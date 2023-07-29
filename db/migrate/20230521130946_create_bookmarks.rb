class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :customer_id, null: false, default: ""
      t.integer :post_id, null: false, default: ""
      t.timestamps null: false
    end
       add_index :bookmarks, [:customer_id, :post_id], unique: true

  end
end