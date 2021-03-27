class PriceList < ApplicationRecord
 require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @supplier = Supplier.find_by(name: row[0])
      @pl = @supplier.price_lists.new(grade: row["grade"], surface: row["surface"], min_thickness_in_mm: row["min_thickness_in_mm"],  width: row["width"], package: row["package"], base_price: row["base_price"], additional_cost: row["additional_cost"], price: ["price"] )
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
      cols = ["grade", "surface", "min_thickness_in_mm", "max_thickness_in_mm", "width", "package", "base_price", "additional_cost", "price"]
     csv << cols
    end
  end
end

