class PriceListsController < ApplicationController
  layout 'admin_lte_2'

  def index
    @s_no = 0
    if params["search"].present?
      @grade = PriceList.find_by(grade: params["search"]["grade"]).grade
      @supplier = @supplier = Supplier.find(params[:search][:supplier_id])
      @pl = PriceList.where(grade: @grade, supplier_id: @supplier.id)
      @price_lists = @supplier.price_lists.order(:grade).select('distinct(grade)')
    else
      @supplier = Supplier.find(params[:format])
      @pl = @supplier.price_lists
      @price_lists = @supplier.price_lists.order(:grade).select('distinct(grade)')
    end
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
  
  def edit
    @pl = PriceList.find(params["id"])
    @supplier = Supplier.find(@pl.supplier_id)
  end
  
  def update
    @pl = PriceList.find(params["id"])
      if @pl.update(pl_params)
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
