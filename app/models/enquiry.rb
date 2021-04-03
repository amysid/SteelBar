class Enquiry < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @enquiry = Enquiry.new(name: row["Customer Name"], source: row["Source"], grade: row["Grade"], classification: row["Classification"], surface: row["Surface"], thick: row["Thickness(mm)"], width: row["Width(mm)"], edge: row["Edge"], length: row["Length"], package_wt: row["Package Wt"], coating: row["Coating"],coating_type: row["Coating Type"], quantity_mt: row["Quantity MT"], custom_premium: row["Custom Premium"], port: row["Port"] )
      @enquiry.save!
     # Enquiry.create! row.to_hash
    end
  end
  
   def self.to_csv(options = {})
    CSV.generate(options) do |csv|
     # cols = ["name", "source", "grade", "classification","surface", "thick", "width", "edge", "length", "package_wt", "coating", "coating_type", "quantity_mt", "custom_premium", "port"]
     cols = ["Customer Name", "Source", "Grade", "Classification", "Surface", "Thickness(mm)", "Width(mm)", "Edge", "Length", "Package Wt", "Coating", "Coating Type", "Quantity MT", "Custom Premium","Port"]
     
     csv << cols
    end
  end

end

