class Pod < ApplicationRecord
require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     Pod.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["export_pod", "container_cost_add"]
     csv << cols
    end
  end
end
