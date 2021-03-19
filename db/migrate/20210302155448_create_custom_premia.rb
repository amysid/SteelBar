class CreateCustomPremia < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_premia do |t|
      t.integer :number_entered
      t.integer :custom_premium_per_mt

      
      t.timestamps
    end
  end
end
