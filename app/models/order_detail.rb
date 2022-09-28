class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def subtotal_tax_price_purchase
    price_purchase * amount
  end

end
