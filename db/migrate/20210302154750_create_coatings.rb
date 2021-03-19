class CreateCoatings < ActiveRecord::Migration[5.2]
  def change
    create_table :coatings do |t|
      t.string :coating
      t.string :coating_type
      t.integer :cost_per_sqm
      t.integer :reading
      
      t.timestamps
    end
  end
end
