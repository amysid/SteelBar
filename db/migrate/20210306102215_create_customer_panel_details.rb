class CreateCustomerPanelDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_panel_details do |t|
      t.integer :grade
      t.string :surface
      t.integer :profit
      t.belongs_to :customer_panel, index: true, foreign_key: true 

      t.timestamps
    end
  end
end
