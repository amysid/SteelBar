class LengthEdge < ApplicationRecord

  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     LengthEdge.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
     cols = ["source", "grade", "length_cost_add", "edge_cost_add"]
     csv << cols
    end
  end

end
