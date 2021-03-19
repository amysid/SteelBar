class CreateGeneralPanels < ActiveRecord::Migration[5.2]
  def change
    create_table :general_panels do |t|
      t.integer :tax_ref
      t.integer :exch_rate
      t.integer :local_transportation_cost
      t.integer :exp

      
      t.timestamps
    end
  end
end
