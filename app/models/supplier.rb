class Supplier < ApplicationRecord
   has_many :price_lists, dependent: :destroy

end
