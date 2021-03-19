class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :name, default: ""

      t.string :email, default: ""
      t.string :password_digest, default: ""
      t.string :verificatin_link, default: ""
      t.boolean :status, default: false

      
      t.timestamps
    end
  end
end
