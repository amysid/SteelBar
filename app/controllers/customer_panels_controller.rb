class CustomerPanelsController < ApplicationController
  layout 'admin_lte_2'
  before_action :find_customer, only: [:edit, :update, :destroy, :new_details, :details_update]
  
  def new
  	@cp = CustomerPanel.new
  end

  def create
    @cp = CustomerPanel.new(customer_panel_params)
    if @cp.save!
      flash[:notice] = ["Customer Panel Created Successfully."]
      redirect_to customer_panels_path
    else
      flash[:alert] = @cp.errors.full_messages
      render :new
    end
  end

  def show
    @s_no = 0
    @cp = CustomerPanel.find_by(id: params[:id])
    @cpd = @cp&.customer_panel_details.paginate(:page => params[:page], :per_page => 20)
  end

  def index
    @s_no = 0
  	@cp = CustomerPanel.all
    @cp = @cp.order("created_at desc").paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.csv { send_data @cp.to_csv }
    end
  end


  def import
    CustomerPanel.import(params[:file])
    redirect_to customer_panels_path, notice: ["Data Imported"]
  end

  def edit
   
  end
 
  def update
    if @cp && @cp.update(customer_panel_params)
      flash[:notice] = ["Customer Panel updated successfully."]
      redirect_to customer_panels_path
    else
      flash[:alert] = (@cp.present? ? @cp.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end

  def new_details
    @customer_panel = CustomerPanel.new
    @customer_panel_details = @customer_panel.customer_panel_details.build
  end

  def create_details
    @cp = CustomerPanel.find( params["cp_id"])
    @cp.update(customer_panel_params)
      if @cp.save
        flash[:notice] = ["Customer Panel Details  created successfullly."]
        redirect_to customer_panels_path
      else
        flash[:alert] = @cpd.errors.full_messages
        render :new_details
      end
  end

  def edit_details
    @cpd = CustomerPanelDetail.find_by(id: params[:format])
  end

  def details_update
      @cpd = CustomerPanelDetail.find_by(id: params[:customer_panel_detail][:cp_id])
      # @category =  @cpd.category
      if @cpd.update(customer_panel_details_params)
        flash[:notice] = ["Customer Panel Details updated successfullly."]
        redirect_to customer_panels_path
      else
        flash[:alert] = @cpd.errors.full_messages
        render :edit_sub_category
      end
    
  end
  private
  def find_customer
    @cp = CustomerPanel.find_by(id: params[:id])
  end

  def customer_panel_params
    params.require(:customer_panel).permit(:name, :email, :container_loading_name, customer_panel_details_attributes: [:id, :grade, :surface, :profit, :customer_panel_id, :_destroy])
  end

  def customer_panel_details_params
    params.require(:customer_panel_detail).permit(:grade, :surface, :profit)
  end

end
