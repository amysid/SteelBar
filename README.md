# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
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 #token
https://datatables.net/examples/api/multi_filter.html

Admin Panel wireframes - https://3vspzz.axshare.com/#id=b938ni&p=dashboard&g=1

Staff Panel New version- https://8emy9o.axshare.com

# price list index
def index
  	@s_no = 0
    if params["search"].present?
      grade = PriceList.find(params["search"]["grade"]).grade
      @supplier = Supplier.find(PriceList.find(params["search"]["grade"]).supplier_id)
      @pl = PriceList.where(grade: grade, supplier_id: @supplier.id)
    else
      @supplier = Supplier.find(params[:format])
  	  @pl = @supplier.price_lists
  	end
  	# respond_to do |format|
   #    format.html
   #    format.csv { send_data @pl.to_csv }
   #  end
  end