class CustomerPanel < ApplicationRecord
   has_many :customer_panel_details
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     CustomerPanel.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
     cols = ["name", "email", "container_loading_name"]
     csv << cols
    end
  end

end
