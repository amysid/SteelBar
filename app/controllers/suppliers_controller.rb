class SuppliersController < ApplicationController
  
  layout 'admin_lte_2'
  
  def index
    @s_no = 0
  	@supplier = Supplier.all
    @supplier = @supplier.order("created_at desc").paginate(:page => params[:page], :per_page => 20)
   
  end

  
  
  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save!
      flash[:notice] = ["supplier Created Successfully."]
      redirect_to suppliers_path
    else
      flash[:alert] = @supplier.errors.full_messages
      render :new
    end
  end

 
  
  private
  
  def supplier_params
    params.require(:supplier).permit(:name)
  end
end

