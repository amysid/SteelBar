class EnquiriesController < ApplicationController
  layout 'admin_lte_2'

  def index
    @sr_no = 0
    if params["search"].present?
    @search = Enquiry.where(name: params["search"]["name"])
    @search = @search.where(:created_at => params["search"]["start"].to_date..params["search"]["end"].to_date) if params["search"]["start"].present?
    @search = @search
    else
    @search = Enquiry.all.order("created_at desc")
    end
    respond_to do |format|
      format.html
      format.csv { send_data @search.to_csv }
    end
    @enquiries = @search.paginate(:page => params[:page], :per_page => 5)
  end
  

  def import
    Enquiry.import(params[:file])
    redirect_to enquiries_path, notice: ["Data Imported"]
  end

  def new
  end
  
  def calculate
   @enquiry = Enquiry.where(unit_price: nil,usd_price: nil)
   redirect_to enquiries_path
  end

  def show
    @enquiry = Enquiry.find(params["id"])
  end

  
end
