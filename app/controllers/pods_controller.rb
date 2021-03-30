class PodsController < ApplicationController
 before_action :find_pod, only: [:edit, :show, :update, :destroy]

  layout 'admin_lte_2'
  
  def index
    @s_no = 0
  	@pod = Pod.all
    @pod = @pod.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.csv { send_data @pod.to_csv }
    end
  end

  def import
    Pod.import(params[:file])
    redirect_to pods_path, notice: ["Data Imported"]
  end
  
  def new
    @pod = Pod.new
  end

  def create
    @pod = Pod.new(pod_params)
    if @pod.save!
      flash[:notice] = ["Pod Created Successfully."]
      redirect_to pods_path
    else
      flash[:alert] = @pod.errors.full_messages
      render :new
    end
  end

  def edit
   
  end
 
  def update
    if @pod && @pod.update(pod_params)
      flash[:notice] = ["Pod updated successfully."]
      redirect_to pods_path
    else
      flash[:alert] = (@pod.present? ? @pod.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end
  
  def destroy
    if @pod.destroy!
      flash[:notice] = ["pod deleted successfully."]
      redirect_to  pods_path
    else
      flash[:alert] = @pod.errors.full_messages
      redirect_to  pods_path
    end
  end

  private
  def find_pod
    @pod = Pod.find_by(id: params[:id])
  end

  def pod_params
    params.require(:pod).permit(:export_pod, :container_cost_add)
  end
end
