class CreateEnquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :source
      t.string :grade
      t.string :classification
      t.string :surface
      t.string :thick
      t.string :width
      t.string :edge
      t.string :length
      t.string :package_wt
      t.string :coating
      t.string :coating_type
      t.string :quantity_mt
      t.string :custom_premium
      t.string :port
      t.string :unit_price
      t.string :usd_price


      
      
      t.timestamps
    end
  end
end

