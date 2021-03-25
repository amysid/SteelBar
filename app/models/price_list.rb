class PriceList < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     PriceList.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["grade", "surface", "min_thickness_in_mm", "max_thickness_in_mm", "width", "package", "base_price", "additional_cost", "price"]
     csv << cols
    end
  end
end

