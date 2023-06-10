class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id,  null: false, default: ""
      t.string :address,      null: false, default: ""
      t.text :introduction, null: false, default: ""
      t.timestamps
    end
  end
end
