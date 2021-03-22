class PriceListsController < ApplicationController
  layout 'admin_lte_2'
 
  def index
  	@s_no = 0
  	@supplier = Supplier.find(params[:format])
  	@pl = @supplier.price_lists
  	# respond_to do |format|
   #    format.html
   #    format.csv { send_data @pl.to_csv }
   #  end
  end


  def import
    PriceList.import(params[:file])
    redirect_to suppliers_path, notice: ["Data Imported"]
  end

  def new
    @supplier = Supplier.find(params[:supplier_id])
    @pl = @supplier.price_lists.new
  end

  def create
    @supplier = Supplier.find(params["supplier"]["id"])
    @pl = @supplier.price_lists.new(pl_params)
    if @pl.save!
      flash[:notice] = ["Pod Created Successfully."]
      redirect_to suppliers_path
    else
      flash[:alert] = @pl.errors.full_messages
      render :new
    end

  end

  private
 
  def pl_params
    params.require(:price_list).permit(:grade, :surface, :min_thickness_in_mm, :max_thickness_in_mm, :width, :package, :base_price, :additional_cost, :price, :supplier_id)
  end

end
