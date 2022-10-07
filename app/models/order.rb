class Order < ApplicationRecord

  validates :customer_id, presence: true
  validates :postal_code_item, presence: true
  validates :prefecture_code_item, presence: true
  validates :address_city_item, presence: true
  validates :address_street_item, presence: true
  validates :address_building_item, presence: true
  validates :name_item, presence: true
  validates :postage, presence: true
  validates :payment, presence: true
  validates :total_amount, presence: true
  validates :order_status, presence: true


  belongs_to :customer
  has_many :order_details, dependent: :destroy


  enum payment: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_payment: 0, payment_confirmation: 1, in_production: 2, shipping_preparation: 3, shipped: 4 }


end
