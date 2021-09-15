class EnquiriesController < ApplicationController
  layout 'admin_lte_2'

  def index
    @sr_no = 0
    if params["search"].present?
    @search = Enquiry.where(name: params["search"]["name"])
    @search = @search.where(:created_at => params["search"]["start"].to_date..params["search"]["end"].to_date) if params["search"]["start"].present?
    @search = @search#.paginate(:page => params[:page], :per_page => 10)
    else
    @search = Enquiry.where(status: false)#.order("created_at desc")#.paginate(:page => params[:page], :per_page => 10)
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
      @calculate_all_cost = @calculate_all_cost&.round(2)
      @usd_cost = exc_usd_cost_with_freight_calculation(@calculate_all_cost,enquiry)
      @fob_cost = fob_price_calculation(@calculate_all_cost,enquiry)
      @cif_cost = cif_price_calculation(@usd_cost,enquiry)

      @usd_cost = @usd_cost&.round(2)
      @fob_cost = @fob_cost&.round(2)
      @cif_cost = @cif_cost&.round(2)

      enquiry.update(unit_price: @calculate_all_cost,usd_price: @usd_cost,fob_price: @fob_cost, cif_price: @cif_cost)
    end
    redirect_to enquiries_path, notice: ["Enquiry Calculated"]
  end

  def show
    @enquiry = Enquiry.find(params["id"])
  end

  def destroy
    @enquiry = Enquiry.find(params["id"])
    if @enquiry.update(status: !@enquiry.status)
      flash[:notice] = ["Deleted Successfully."]
      redirect_to  enquiries_path
    else
      flash[:alert] = @enquiry.errors.full_messages
      redirect_to  enquiries_path
    end
  end

  private

  def calculate_all(grade, enquiry)
    @price_list = Supplier.find_by(name: enquiry.source).price_lists.where(grade: grade).where(':thick BETWEEN min_thickness_in_mm AND max_thickness_in_mm', thick: enquiry.thick.to_f).first
    @edge = LengthEdge.find_by(source: enquiry.source, grade: enquiry.grade)
    @surface = Surface.find_by(surface: enquiry.surface)
    @rmb_cost = @price_list&.price
    @surface_sqm_cost = calculate_surface_cost(@surface, enquiry) #SURFACE can be a base level OR unique. If unique such as N4 or 8K then have to add the SURFACE process fee to the base surface.
    @length_cost = length_cost(enquiry.length, @edge, enquiry.package_wt) #if LENGTH is COIL (base length) no extra process fee, but if LENGTH is any numerical value then addt he respective process fee based on the SOURCE / GRADE in the enquiry.
    @edge_cost = edge_cost(@edge, enquiry.edge) #If EDGE is M (base edge) no extra process fee, but if EDGE is S then must add the respective process fee for S based on the SOURCE / GRADE in the enquiry.
    @coating_cost = coating_cost(enquiry.coating, enquiry.coating_type,enquiry.thick) # Under COATING if there is paper or no value then no extra process fee. But if there is any other COATING and COATING TYPE which matches to the values in the coating backend then add the respective sqm process fee (sqm converted to per MT)
    @custom_p_cost = custom_premium_cost(enquiry) #CUSTOM PREMIUM is an additional process fee we have to add based on the enquiry (can be because of scarce raw materials or commission for agent). This is always in per MT.
    @rmb_cost = 0 if !@price_list&.base_price.present?
    @other_charges_length = other_charges_length(enquiry)
    @other_charges_edge = other_charges_edge(enquiry)
    @total_cost = @rmb_cost + @surface_sqm_cost + @coating_cost + @custom_p_cost + @other_charges_length + @other_charges_edge
  end

  def calculate_surface_cost(surface, enquiry)
    @surface = surface
    density = 7.93
    thickness = enquiry.thick.to_f
    @sqmcost =  @surface&.cost
    if @surface.surface == "SP"
      surface_sqmcost = 350
    elsif @surface.surface == "DP"
      surface_sqmcost = 450
    else
      surface_sqmcost = (@surface.cost/thickness/density)*1000 
    end
    surfaces_without_process_fee = ['N1','2B','2BA','BA']
    if surfaces_without_process_fee.include?(enquiry.surface)
      surface_sqmcost = surface_sqmcost#process fee,, per SQM calculation So basically, the SQM fee per MT is calculated using the SQM PROCESS FEE and the THICKNESS in the enquiry. The 7.93*1000 is a density constant.
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
    if length.upcase == "COIL"
      process_fee = 0
    else
      process_fee = edge.length_cost_add
    end
    if length.upcase == "COIL" && package_wt.to_i < 4
      process_fee = process_fee + 100
    elsif length.is_a?(Integer) && package_wt.to_i < 4
       process_fee = process_fee + 100
    end
    process_fee
  end


  def coating_cost(coating, coating_type, thickness)
    if coating.upcase == "PAPER" || coating == nil
      process_fee = 0
    else
    density = 7.93
    thickness = thickness.to_f
    @coating = Coating.find_by(coating: coating, coating_type: coating_type)
    @fee = @coating&.cost_per_sqm
    process_fee = (@fee/thickness/density)*1000  #based on the SOURCE / GRADE in the enquiry. (<PROCESS FEE> / <THICKNESS> / 7.93*1000)
    process_fee = process_fee
    end
  end

  def custom_premium_cost(enquiry)
    enquiry.custom_premium.to_i
  end

  def other_charges_length(enquiry)
    if enquiry.length.upcase == "COIL"
      process_fee = 0
     else
      enquiry.length.to_i.is_a?(Integer)
      process_fee = 250
    end                  
    # if enquiry.grade == 201 && enquiry.length.is_a?(Integer) && enquiry.edge.is_a?(Integer)
    #   length_edge_cost = le_cost-100
    # else
    #   length_edge_cost = le_cost
    # end
  end

  def other_charges_edge(enquiry)
    if enquiry.edge.upcase == "M"
      process_fee = 0
     else
      enquiry.edge.upcase == "S"
      process_fee = 200
    end                    
  end
  
  def exc_usd_cost_with_freight_calculation(rmb_cost, enquiry)
   port = enquiry.port
   exchange_rate_usd = rmb_cost/GeneralPanel.last.exch_rate  + GeneralPanel.last.local_transportation_cost
   freight = Pod.find_by(export_pod: port)&.container_cost_add
   container_loading = CustomerPanel.find_by(name: enquiry.name)&.container_loading_name&.to_i
   freight_cal = freight/container_loading
   final_usd_cost = exchange_rate_usd + freight_cal
  end

  def fob_price_calculation(rmb_cost,enquiry)
   exchange_rate_usd = rmb_cost/GeneralPanel.last.exch_rate  + GeneralPanel.last.local_transportation_cost
   profit = CustomerPanel.find_by(name: enquiry.name).customer_panel_details.where(grade: enquiry.grade.to_i, surface: enquiry.classification)&.first&.profit
   final_fob_cost = (exchange_rate_usd*(100+profit))/100
  end

  def cif_price_calculation(usd_cost,enquiry)
   final_usd_cost = usd_cost
   profit = CustomerPanel.find_by(name: enquiry.name).customer_panel_details.where(grade: enquiry.grade.to_i, surface: enquiry.classification)&.first&.profit
   final_cif_cost = (final_usd_cost*(100+profit))/100
  end

end