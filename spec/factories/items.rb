FactoryBot.define do
  factory :item do
    name      {Faker::Name.name}      # "商品名"
    price     {1000}                  # "価格"
    info      {Faker::Lorem.sentence} # "説明"
    user_id                {1} # "ユーザーid"
    category_id            {1} # "カテゴリー"
    sales_status_id        {1} # "状態"
    shipping_fee_status_id {1} # "配送料"
    prefecture_id          {1} # "発送元"
    scheduled_delivery_id  {1} # "発送予定日"

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end