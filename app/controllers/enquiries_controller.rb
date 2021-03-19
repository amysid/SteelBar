class EnquiriesController < ApplicationController
  layout 'admin_lte_2'

  def index
    @sr_no = 0
    @search = Enquiry.all.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
    @enquiries_count = @search.count
    @enquiries = enquiries_search
    respond_to do |format|
      format.html
      format.csv { send_data @enquiries.to_csv }
    end
    @enquiries = @enquiries#.decorate
  end
  

  def import
    Enquiry.import(params[:file])
    redirect_to enquiries_path, notice: ["Data Imported"]
  end

  def new
  end

  def create
  end

  
end
