class CustomPremiumsController < ApplicationController
before_action :find_cp, only: [:edit, :show, :update, :destroy]

  layout 'admin_lte_2'
  
  def index
    @s_no = 0
  	@cp = CustomPremium.all
    @cp = @cp.order("created_at desc").paginate(:page => params[:page], :per_page => 20)

  end
  
  def new
    @cp = cp.new
  end

  def create
    @cp = CustomPremium.new(cp_params)
    if @cp.save!
      flash[:notice] = ["Custom Premium Created Successfully."]
      redirect_to custom_premiums_path
    else
      flash[:alert] = @cp.errors.full_messages
      render :new
    end
  end

  def edit
   
  end
 
  def update
    if @cp && @cp.update(cp_params)
      flash[:notice] = ["Custom Premium updated successfully."]
      redirect_to custom_premiums_path
    else
      flash[:alert] = (@cp.present? ? @cp.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end
  
  def destroy
    if @cp.destroy!
      flash[:notice] = ["Custom Premium deleted successfully."]
      redirect_to  custom_premiums_path
    else
      flash[:alert] = @cp.errors.full_messages
      redirect_to  custom_premiums_path
    end
  end

  private
  def find_cp
    @cp = CustomPremium.find_by(id: params[:id])
  end

  def cp_params
    params.require(:cp).permit(:number_entered, :custom_premium_per_mt)
  end

end
