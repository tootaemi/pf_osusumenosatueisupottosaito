class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :email,                           null: false, default: ""
      t.string :encrypted_password,              null: false, default: ""
      t.timestamps null: false

    end
  end
end
