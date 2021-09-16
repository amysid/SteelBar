class Supplier < ApplicationRecord
   has_many :price_lists, dependent: :destroy
   has_many :basic_prices, dependent: :destroy
   
end
