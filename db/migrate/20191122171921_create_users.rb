class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name, default: ""
      t.string :email, default: ""
      t.string :mobile, default: ""
      t.string :email, default: ""
      t.integer :gender, default: 0
      t.integer :role, default: 1
      t.string :address, default: ""
      t.string :password_digest, default: ""
      t.string :verificatin_link, default: ""
      t.string :image

      t.timestamps
    end
  end
end
