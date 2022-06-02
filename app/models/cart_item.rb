class CartItem < ApplicationRecord

  validates :item_id, presence: true
  validates :customer_id, presence: true
  validates :amount, presence: true

  belongs_to :customer
  belongs_to :item

  def sum_tax_price
    item.add_tax_price * amount
  end

end
