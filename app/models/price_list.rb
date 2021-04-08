class PriceList < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @supplier = Supplier.find_by(name: row[0])
      @pl = @supplier.price_lists.new(grade: row["Grade"], surface: row["Surface"], min_thickness_in_mm: row["MIN (Thickness in  mm)"], max_thickness_in_mm: row["MAX (Thickness in  mm)"], width: row["Width(mm)"], package: row["Package Wt"], base_price: row["Base Price  (RMB)"], additional_cost: row["Additional Cost(RMB)"], price: ["Price(RMB)"] )
     @pl.save!
    # PriceList.create! row.to_hash
    end
  end
  
  #  def import
  #    csv = File.read(params[:file].path)
  #    CSV.parse(csv, headers: true).each do |row|
  #    @supplier = Supplier.find_by(name: row[0])
  #    binding.pry
  #    @pl = @supplier.price_lists.new(row.to_h)
  #    @pl.save!
  #    redirect_to suppliers_path, notice: ["Data Imported"]
  #   end
  # end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      cols = ["Grade", "Surface", "MIN (Thickness in  mm)", "MAX (Thickness in  mm)", "Width(mm)", "Package Wt", "Base Price  (RMB)", "Additional Cost(RMB)", "Price(RMB)"]
     csv << cols
    end
  end
end

