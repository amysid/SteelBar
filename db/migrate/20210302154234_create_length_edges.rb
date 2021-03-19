class CreateLengthEdges < ActiveRecord::Migration[5.2]
  def change
    create_table :length_edges do |t|
      t.string :source
      t.integer :grade
      t.integer :length_cost_add
      t.integer :edge_cost_add
      
      t.timestamps
    end
  end
end
