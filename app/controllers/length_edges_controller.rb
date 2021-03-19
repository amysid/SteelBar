class LengthEdgesController < ApplicationController
  before_action :find_length_edge, only: [:edit, :show, :update, :destroy]

  layout 'admin_lte_2'
  
  def index
    @s_no = 0
  	@le = LengthEdge.all
    @le = @le.order("created_at desc").paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.csv { send_data @le.to_csv }
    end
  end
  
  def import
    LengthEdge.import(params[:file])
    redirect_to length_edges_path, notice: ["Data Imported"]
  end

  def new
    @le = LengthEdge.new
  end

  def create
    @le = LengthEdge.new(le_params)
    if @le.save!
      flash[:notice] = ["Length Edge Created Successfully."]
      redirect_to length_edges_path
    else
      flash[:alert] = @le.errors.full_messages
      render :new
    end
  end

  def edit
   
  end
 
  def update
    if @le && @le.update(le_params)
      flash[:notice] = ["Length Edge updated successfully."]
      redirect_to length_edges_path
    else
      flash[:alert] = (@le.present? ? @le.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end
  
  def destroy
    if @le.destroy!
      flash[:notice] = ["Length Edge deleted successfully."]
      redirect_to  length_edges_path
    else
      flash[:alert] = @le.errors.full_messages
      redirect_to  length_edges_path
    end
  end

  private
  def find_length_edge
    @le = LengthEdge.find_by(id: params[:id])
  end

  def le_params
    params.require(:length_edge).permit(:source, :grade, :length_cost_add, :edge_cost_add)
  end
end
