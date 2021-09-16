class CreateBasicPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_prices do |t|
      t.integer :grade
      t.integer :base_price
      t.belongs_to :supplier, index: true, foreign_key: true 
      
      t.timestamps
    end
  end
end
