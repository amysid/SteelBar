class CustomerPanel < ApplicationRecord
  has_many :customer_panel_details, inverse_of: :customer_panel, dependent: :destroy
  accepts_nested_attributes_for :customer_panel_details, reject_if: :all_blank, allow_destroy: true
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
