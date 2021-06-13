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
    end
    redirect_to enquiries_path
  end

  def show
    @enquiry = Enquiry.find(params["id"])
  end

  private

  def calculate_all(grade, enquiry)
    @price_list = PriceList.find_by(grade: grade)
    @surface = Surface.find_by(surface: enquiry.surface)
    @thickness = @price_list&.min_thickness_in_mm
    @width = @price_list&.width
    @rmb_cost = @price_list&.base_price
    @surface_sqm_cost = calculate_surface_cost(@surface, enquiry)
    @length_cost = find_length_cost(enquiry.length, enquiry.package_wt) 
    @rmb_cost = @price_list ? @price_list.base_price  : 0 + @length_cost
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
  end

  # def find_surface(grade, surface, enquiry)
  #   surfaces_without_process_fee = ['N1','2B','2BA','BA']
  #   if surfaces_without_process_fee.include?(surface)
  #     process_fee = 0
  #   else
  #     # (sqmcost/thickness/density)*1000
  #     # (2/.054/7.93)   *1000  
  #     @surface = Surface.find_by(surface: surface)
  #     @density = 7.93
  #     @thickness = enquiry.thick
  #     @cost =  @surface.cost
  #     3000
  #     process_fee = 0 #based on the SOURCE / GRADE in the enquiry.
  #   end 
  # end

  # def find_thickness(grade)
  #   @thickness = PriceList.find_by(grade: grade).min_thickness_in_mm
  # end

  # def find_width(enquiry)
  #   # if width is not a base width
  #   @width_cost = PriceList.find_by(width: enquiry.width)&.price
  # end
  
  # def find_edge(edge)
  #   if edge == "M"
  #     process_fee = 0
  #     if (source == "HW")
  #       cost = 200
  #     else
  #       cost = 300
  #     end
  #   else
  #     if (source == "RX")
  #       edge cost = 300
  #     else 
  #       process_fee = 0 #based on the SOURCE / GRADE in the enquiry.
  #       cost = 200
  #     end
  #   end
  # end

  def find_length_cost(length, package_wt)
    if length == "COIL"
      if (package_wt.to_i < 4)
        length_cost = 100
      end
    else
      if (package_wt.to_i < 2)
        length_cost = 100
      end
    end
    # if length == "COIL"
    #   process_fee = 0
    #   cost = 3000
    #   if (package_wt < 4)
    #     cost += 100
    #   end
    # else
    #   process_fee =  0 #addt he respective process fee based on the SOURCE / GRADE in the enquiry.
    #   if (package_wt < 2)
    #     cost += 100
    #   end
    # end
  end

  # def find_package_weight
  # end

  # def coating(coating)
  #   if (coating == "Paper" || "")
  #     process_fee = 0
  #   else
  #     process_fee = 0 #based on the SOURCE / GRADE in the enquiry.
  #   end

  # end

  # def coating_type
  # end

  # def find_quantity_mt
  # end

  # def find_custom_premium
  # end

  # def process_fee
  # end

  # def cost
  # end
end
