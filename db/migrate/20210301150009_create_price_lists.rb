class CreatePriceLists < ActiveRecord::Migration[5.2]
  def change
    create_table :price_lists do |t|
      t.integer :grade
      t.string :surface
      t.integer :min_thickness_in_mm
      t.integer :max_thickness_in_mm
      t.integer :width
      t.string :package
      t.integer :base_price
      t.integer :additional_cost
      t.integer :price
      t.belongs_to :supplier, index: true, foreign_key: true 

       
      t.timestamps
    end
  end
end
