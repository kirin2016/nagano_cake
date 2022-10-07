class Address < ApplicationRecord

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true



  def full_address
    ['〒', postal_code, '　', prefecture_name, address_city, address_street, address_building, '　', name].join('')
  end


  belongs_to :customer

end
