class CreatePods < ActiveRecord::Migration[5.2]
  def change
    create_table :pods do |t|
      t.string :export_pod
      t.integer :container_cost_add
      
      t.timestamps
    end
  end
end
