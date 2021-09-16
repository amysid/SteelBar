class BasicPricesController < ApplicationController
  layout 'admin_lte_2'
 
 
  def index
    @s_no = 0
      $supplier = Supplier.find(params[:format])
      @bp = $supplier.basic_prices.order("created_at desc")
      @basic_prices = $supplier.basic_prices.order(:grade).select('distinct(grade)')
    
  end
  

  def new
    @supplier = Supplier.find(params[:supplier_id])
    @bp = @supplier.basic_prices.new
  end
  
  def edit
    @bp = BasicPrice.find(params["id"])
    @supplier = Supplier.find(@bp.supplier_id)
  end
  
  def update
    @bp = BasicPrice.find(params["id"])
      if @bp.update(bp_params)
        Supplier.find(@bp.supplier_id).price_lists.where(grade: @bp.grade).map{|x| x.update(base_price: @bp.base_price, price: @bp.base_price+x.additional_cost)} if Supplier.find(@bp.supplier_id).price_lists.where(grade: @bp.grade).present?
        flash[:notice] = ["Updated Successfullly."]
        redirect_to suppliers_path
      else
        flash[:alert] = @bp.errors.full_messages
        render :edit_sub_category
      end
  end
  
  def create
    @supplier = Supplier.find(params["supplier"]["id"])
    @bp = @supplier.basic_prices.new(bp_params)
    if @bp.save!
      flash[:notice] = ["Created Successfully."]
      redirect_to basic_prices_path(@supplier.id)
    else
      flash[:alert] = @bp.errors.full_messages
      render :new
    end

  end

  def destroy
    @bp = BasicPrice.find(params["id"])
    if @bp.destroy!
      flash[:notice] = ["Deleted Successfully."]
      redirect_to  suppliers_path
    else
      flash[:alert] = @bp.errors.full_messages
      redirect_to  suppliers_path
    end
  end

  private
 
  def bp_params
    params.require(:basic_price).permit(:grade, :base_price, :supplier_id)
  end

end
