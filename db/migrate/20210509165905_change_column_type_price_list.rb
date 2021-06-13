class ChangeColumnTypePriceList < ActiveRecord::Migration[5.2]
  def change
  	change_column :price_lists, :min_thickness_in_mm, :float, default: 0
  	change_column :price_lists, :max_thickness_in_mm, :float, default: 0

  end
end
