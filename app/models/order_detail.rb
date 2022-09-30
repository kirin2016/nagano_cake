class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def subtotal_tax_price_purchase
    price_purchase * amount
  end

  enum create_status: { cannot_start: 0, waiting_production: 1, in_production: 2, complete_production: 3 }

end
