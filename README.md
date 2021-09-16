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




  If Length is COIL add 0
If length is any Integer add 250

If Edge is M add 0
if Edge is S add 200

=======Done=========


Cost = Our production cost
Price = Our selling price

RMB COST = final cost
FOB PRICE = ((RMB COST/EXCH RATE)+LOCAL TRANSPORTATION COST)*(100%+PROFIT)
CIF PRICE = ((RMB COST/EXCH RATE)+ LOCAL TRANSPORTATION COST+(FREIGHT/LOADING PER CONTAINER)))*(100%+PROFIT)


rmb price = 11010
fob price = 1963.5

=======Done=========

Admin - show all prices, COST RMB, FOB USD, CIF USD
staff- show only FOB USD, CIF USD

=======Done=========

