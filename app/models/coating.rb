class Coating < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     Coating.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["coating", "coating_type", "cost_per_sqm", "reading"]
     csv << cols
    end
  end
end


