class AddFobcifPriceToEnquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :enquiries, :fob_price, :string
    add_column :enquiries, :cif_price, :string
    add_column :enquiries, :status, :boolean, default: false
  end
end
