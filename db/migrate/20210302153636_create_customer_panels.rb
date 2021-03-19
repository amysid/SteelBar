class CreateCustomerPanels < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_panels do |t|
      t.string :name
      t.string :email
      t.string :container_loading_name
      
      t.timestamps
    end
  end
end
