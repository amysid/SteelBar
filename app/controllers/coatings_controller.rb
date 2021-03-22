class CoatingsController < ApplicationController
before_action :find_coating, only: [:edit, :show, :update, :destroy]

  layout 'admin_lte_2'
  
  def index
    @s_no = 0
  	@coating = Coating.all
    @coating = @coating.order("created_at desc").paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.csv { send_data @coating.to_csv }
    end
  end

  def import
    Coating.import(params[:file])
    redirect_to coatings_path, notice: ["Data Imported"]
  end
  
  def new
    @coating = Coating.new
  end

  def create
    @coating = Coating.new(coating_params)
    if @coating.save!
      flash[:notice] = ["Coating Created Successfully."]
      redirect_to coatings_path
    else
      flash[:alert] = @coating.errors.full_messages
      render :new
    end
  end

  def edit
   
  end
 
  def update
    if @coating && @coating.update(coating_params)
      flash[:notice] = ["Coating updated successfully."]
      redirect_to coatings_path
    else
      flash[:alert] = (@coating.present? ? @coating.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end
  
  def destroy
    if @coating.destroy!
      flash[:notice] = ["Coating deleted successfully."]
      redirect_to  coatings_path
    else
      flash[:alert] = @coating.errors.full_messages
      redirect_to  coatings_path
    end
  end

  private
  def find_coating
    @coating = Coating.find_by(id: params[:id])
  end

  def coating_params
    params.require(:coating).permit(:coating, :coating_type, :cost_per_sqm, :reading)
  end
end
