class StaffsController < ApplicationController
  before_action :find_staff, only: [:edit, :show, :update, :destroy, :change_status]

  layout 'admin_lte_2'
  
  def index
    @s_no = 0
    @staffs = Staff.search_ilike(params[:search]) if params[:search].present?
  	@staffs ||= Staff.all
    @staffs = @staffs.order("created_at desc").paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
      format.csv { send_data @staffs.to_csv }
    end
  end
  
  def import
    Staff.import(params[:file])
    redirect_to staffs_path, notice: ["Data Imported"]
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    if @staff.save!
      flash[:notice] = ["Staff Created Successfully."]
      redirect_to staffs_path
    else
      flash[:alert] = @staff.errors.full_messages
      render :new
    end
  end

  def edit
   
  end
 
  def update
    if @staff && @staff.update(staff_params)
      flash[:notice] = ["Staff updated successfully."]
      redirect_to staffs_path
    else
      flash[:alert] = (@staff.present? ? @staff.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end

  def change_status
    # @staff = Staff.find(params[:user_id])
    if @staff.update(status: !@staff.status)
      flash[:success] = ["Status changed successfully!"]
    else
      flash[:success] = @status.errors.full_messages
    end
    redirect_to staffs_path
    # render json: { status: 200, ok: true, msg: "Status changed successfully!"}
  end

  private
  def find_staff
    @staff = Staff.find_by(id: params[:id])
  end

  def staff_params
    params.require(:staff).permit(:name, :email, :password, :confirmation_password)
  end
end
