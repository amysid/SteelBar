class SurfacesController < ApplicationController
  before_action :find_surface, only: [:edit, :show, :update, :destroy]

  layout 'admin_lte_2'
  
  def index
    @s_no = 0
  	@surface = Surface.all
    @surface = @surface.order("created_at desc")#.paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.csv { send_data @surface.to_csv }
    end
  end

  def import
    Surface.import(params[:file])
    redirect_to surfaces_path, notice: ["Data Imported"]
  end
  
  def new
    @surface = Surface.new
  end

  def create
    @surface = Surface.new(surface_params)
    if @surface.save!
      flash[:notice] = ["Surface Created Successfully."]
      redirect_to surfaces_path
    else
      flash[:alert] = @surface.errors.full_messages
      render :new
    end
  end

  def edit
   
  end
 
  def update
    if @surface && @surface.update(surface_params)
      flash[:notice] = ["Surface updated successfully."]
      redirect_to surfaces_path
    else
      flash[:alert] = (@surface.present? ? @surface.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end
  
  def destroy
    if @surface.destroy!
      flash[:notice] = ["Surface deleted successfully."]
      redirect_to  surfaces_path
    else
      flash[:alert] = @surface.errors.full_messages
      redirect_to  surfaces_path
    end
  end

  private
  def find_surface
    @surface = Surface.find_by(id: params[:id])
  end

  def surface_params
    params.require(:surface).permit(:grade, :surface, :cost, :unit)
  end
end
