class Enquiry < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     Enquiry.create! row.to_hash
    end
  end
  
   def self.to_csv(options = {})
    CSV.generate(options) do |csv|
     cols = ["name", "source", "grade", "classification","surface", "thick", "width", "edge", "length", "package_wt", "coating", "coating_type", "quantity_mt", "custom_premium", "port"]
     csv << cols
    end
  end

end

