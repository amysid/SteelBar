class EnquiriesController < ApplicationController
  layout 'admin_lte_2'

  def index
    @sr_no = 0
    if params["search"].present?
    @search = Enquiry.where(name: params["search"]["name"])
    @search = @search.where(:created_at => params["search"]["start"].to_date..params["search"]["end"].to_date) if params["search"]["start"].present?
    @search = @search.paginate(:page => params[:page], :per_page => 10)
    else
    @search = Enquiry.all.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @search.to_csv }
    end
    @enquiries = @search
  end
  

  def import
    Enquiry.import(params[:file])
    redirect_to enquiries_path, notice: ["Data Imported"]
  end

  def new
  end
  
  def calculate
    @enquiries = Enquiry.where(unit_price: nil,usd_price: nil)
    @enquiries.each do |enquiry|
      @grade = enquiry.grade
      @calculate_all_cost = calculate_all(@grade, enquiry)
      enquiry.update(unit_price: @calculate_all_cost)
    end
    redirect_to enquiries_path
  end

  def show
    @enquiry = Enquiry.find(params["id"])
  end

  private

  def calculate_all(grade, enquiry)
    @price_list = Supplier.find_by(name: enquiry.source).price_lists.find_by(grade: grade)
    @edge = LengthEdge.find_by(source: enquiry.source, grade: enquiry.grade)
    @surface = Surface.find_by(surface: enquiry.surface)
    @rmb_cost = @price_list&.base_price
    @surface_sqm_cost = calculate_surface_cost(@surface, enquiry) #SURFACE can be a base level OR unique. If unique such as N4 or 8K then have to add the SURFACE process fee to the base surface.
    @length_cost = length_cost(enquiry.length, @edge, enquiry.package_wt) #if LENGTH is COIL (base length) no extra process fee, but if LENGTH is any numerical value then addt he respective process fee based on the SOURCE / GRADE in the enquiry.
    @edge_cost = edge_cost(@edge, enquiry.edge) #If EDGE is M (base edge) no extra process fee, but if EDGE is S then must add the respective process fee for S based on the SOURCE / GRADE in the enquiry.
    @coating_cost = coating_cost(enquiry.coating) # Under COATING if there is paper or no value then no extra process fee. But if there is any other COATING and COATING TYPE which matches to the values in the coating backend then add the respective sqm process fee (sqm converted to per MT)
    @custom_p_cost = custom_premium_cost(enquiry) #CUSTOM PREMIUM is an additional process fee we have to add based on the enquiry (can be because of scarce raw materials or commission for agent). This is always in per MT.
    @total_cost = @rmb_cost + @surface_sqm_cost + @length_cost + @edge_cost + @coating_cost + @custom_p_cost
  end

  def calculate_surface_cost(surface, enquiry)
    @surface = surface
    density = 7.93
    thickness = enquiry.thick
    @sqmcost =  @surface&.cost
    if @surface = "SP"
      surface_sqmcost = 350
    elsif @surface.surface = "DP"
      surface_sqmcost = 450
    else
      surface_sqmcost = (@surface.cost/thickness/density)*1000 
    end
    surfaces_without_process_fee = ['N1','2B','2BA','BA']
    if surfaces_without_process_fee.include?(enquiry.surface)
      surface_sqmcost = surface_sqmcost + 0 #process fee,, per SQM calculation So basically, the SQM fee per MT is calculated using the SQM PROCESS FEE and the THICKNESS in the enquiry. The 7.93*1000 is a density constant.
    end   
  end
  
  def edge_cost(edge, enquiry_edge)
    if enquiry_edge == "M"
      process_fee = 0
    else
      process_fee = edge.edge_cost_add
    end
  end

  def length_cost(length, edge, package_wt)
    if length == "COIL"
      process_fee = 0
    else
      process_fee = edge.length_cost_add
    end
    if length == "COIL" && package_wt.to_i < 4
      process_fee = process_fee + 100
    elsif length.is_a?(Integer) && package_wt.to_i < 4
       process_fee = process_fee + 100
    end
    process_fee
  end

  def coating_cost(coating)
    if (coating == "Paper" || "")
      process_fee = 0
    else
      process_fee = 0 #based on the SOURCE / GRADE in the enquiry.
    end
  end

  def custom_premium_cost(enquiry)
    enquiry.custom_premium.to_i
  end

end