class Order < ApplicationRecord

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def prefecture_name_item
    JpPrefecture::Prefecture.find(code: prefecture_code_item).try(:name)
  end

  def prefecture_name_item=(prefecture_name)
    self.prefecture_code_item = JpPrefecture::Prefecture.find(name: prefecture_name_item).code
  end

  belongs_to :customer
  has_many :order_details, dependent: :destroy


  enum payment_method: { credit_card: 0, transfer: 1 }

end
