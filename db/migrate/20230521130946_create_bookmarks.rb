class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :post_id, null: false, default: ""
      t.timestamps null: false
    end
  end
end
