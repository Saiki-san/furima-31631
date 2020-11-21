class ShippingFeeStatus < ActiveHash::Base
  # shipping_fee_status_id 配送料の負担
  self.data = [
    {id: 0, name: '---'}, {id: 1, name: '着払い(購入者負担)'}, {id: 2, name: '送料込み(出品者負担)'}
  ]

  include ActiveHash::Associations
  has_many :items
end