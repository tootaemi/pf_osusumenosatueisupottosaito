class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id, null: false, default: ""
      t.integer :post_id, null: false, default: ""
      t.string :comment,  null: false, default: ""
      t.timestamps null: false
    end
  end
end


