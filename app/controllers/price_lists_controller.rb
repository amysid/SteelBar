class PriceListsController < ApplicationController
  layout 'admin_lte_2'

  # def index
  # 	@s_no = 0
  #   if params[:search].present?
  #     $supplier = Supplier.find(params[:search][:supplier_id])
  #     @pl = PriceList.where(id: params[:search][:grade]).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  # 	else
  #     $supplier = Supplier.find(params[:format])
  #     @pl = $supplier.price_lists.order("created_at desc").paginate(:page => params[:page], :per_page => 10)

  #   end
   
  # end


  def index
    @s_no = 0
    if params["search"].present?
      @grade = PriceList.find_by(grade: params["search"]["grade"]).grade
      $supplier = Supplier.find(params[:search][:supplier_id])
      @pl = PriceList.where(grade: @grade, supplier_id: $supplier.id).order("created_at desc")
      @price_lists = $supplier.price_lists.order(:grade).select('distinct(grade)')
    else
      $supplier = Supplier.find(params[:format])
      @pl = $supplier.price_lists.order("created_at desc")
      @price_lists = $supplier.price_lists.order(:grade).select('distinct(grade)')
    end
    
  end

  
  def pricelistsample
    @pl = PriceList.all
   respond_to do |format|
      format.html
      format.csv { send_data @pl.to_csv }
    end
  end

  def import
    PriceList.import(params[:file], $supplier)
    redirect_to suppliers_path, notice: ["Data Imported"]
  end

  def new
    @supplier = Supplier.find(params[:supplier_id])
    @pl = @supplier.price_lists.new
  end
  
  def edit
    @pl = PriceList.find(params["id"])
    @supplier = Supplier.find(@pl.supplier_id)
  end
  
  def update
    @pl = PriceList.find(params["id"])
    bp = Supplier.find(@pl.supplier_id).basic_prices.where(grade: @pl.grade).first.base_price

      if @pl.update(pl_params)
        @pl.update(base_price: bp,price: bp+@pl.additional_cost)
        flash[:notice] = ["Updated Successfullly."]
        redirect_to suppliers_path
      else
        flash[:alert] = @pl.errors.full_messages
        render :edit_sub_category
      end
  end
  
  def create
    @supplier = Supplier.find(params["supplier"]["id"])
    @pl = @supplier.price_lists.new(pl_params)
    if @pl.save!
      bp = @supplier.basic_prices.where(grade: @pl.grade).first.base_price
      @pl.update(base_price: bp,price: bp+@pl.additional_cost)
      flash[:notice] = ["Created Successfully."]
      redirect_to price_lists_path(@supplier.id)
    else
      flash[:alert] = @pl.errors.full_messages
      render :new
    end

  end

  def destroy
    @pl = PriceList.find(params["id"])
    if @pl.destroy!
      flash[:notice] = ["Deleted Successfully."]
      redirect_to  suppliers_path
    else
      flash[:alert] = @surface.errors.full_messages
      redirect_to  suppliers_path
    end
  end

  private
 
  def pl_params
    params.require(:price_list).permit(:grade, :surface, :min_thickness_in_mm, :max_thickness_in_mm, :width, :package, :base_price, :additional_cost, :price, :supplier_id)
  end

end
