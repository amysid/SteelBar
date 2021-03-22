class Surface < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     Surface.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["grade", "surface", "surface_type", "cost", "unit"]
     csv << cols
    end
  end
end


