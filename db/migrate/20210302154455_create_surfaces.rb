class CreateSurfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :surfaces do |t|
      t.integer :grade
      t.string :surface
      t.string :surface_type
      t.integer :cost
      t.string :unit
      
      t.timestamps
    end
  end
end
