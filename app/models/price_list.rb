class PriceList < ApplicationRecord
 require 'csv'
  def self.import(file, supplier)
    CSV.foreach(file.path, headers: true) do |row|
      @supplier = supplier
      # pls = @supplier.price_lists.where(grade: row["Grade"], surface: row["Surface"]).first
      pls = @supplier.price_lists.where(grade: row["Grade"], surface: row["Surface"], min_thickness_in_mm: row["MIN (Thickness in  mm)"], max_thickness_in_mm: row["MAX (Thickness in  mm)"], width: row["Width(mm)"]).first
      if pls.present? 
       pls.update_attributes(grade: row["Grade"], surface: row["Surface"], min_thickness_in_mm: row["MIN (Thickness in  mm)"], max_thickness_in_mm: row["MAX (Thickness in  mm)"], width: row["Width(mm)"], additional_cost: row["Additional Cost(RMB)"] ) 
       pls.save!
      else
       @pl = @supplier.price_lists.new(grade: row["Grade"], surface: row["Surface"], min_thickness_in_mm: row["MIN (Thickness in  mm)"], max_thickness_in_mm: row["MAX (Thickness in  mm)"], width: row["Width(mm)"], additional_cost: row["Additional Cost(RMB)"] )
       @pl.save!
       bp = @supplier.basic_prices.where(grade: @pl.grade).first.base_price if @supplier.basic_prices.where(grade: @pl.grade).present?
       @pl.update(base_price: bp,price: bp+@pl.additional_cost) if @supplier.basic_prices.where(grade: @pl.grade).present?
       
      end
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
      cols = ["Grade", "Surface", "MIN (Thickness in  mm)", "MAX (Thickness in  mm)", "Width(mm)","Additional Cost(RMB)"]
     csv << cols
    end
  end
end

