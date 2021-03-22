class CustomPremium < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     CustomPremium.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["number_entered", "custom_premium_per_mt"]
     csv << cols
    end
  end

end
