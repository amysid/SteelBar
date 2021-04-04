class Surface < ApplicationRecord
 require 'csv'
  
  
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @surface = Surface.new(grade: row["Grade"], surface: row["Surface"], cost: row["Cost"], unit: row["Unit"])
     @surface.save!
    end
  end


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["Grade", "Surface","Cost", "Unit"]
     csv << cols
    end
  end
end


