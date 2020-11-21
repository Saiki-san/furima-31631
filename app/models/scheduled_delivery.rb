class ScheduledDelivery < ActiveHash::Base
  # scheduled_delivery_id 発送までの日数
  self.data = [
    {id: 0, name: '---'},       {id: 1, name: '1~2日で発送'}, {id: 2, name: '2~3日で発送'},
    {id: 3, name: '4~7日で発送'}
  ]

  include ActiveHash::Associations
  has_many :items
end