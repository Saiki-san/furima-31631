FactoryBot.define do
  factory :token_address_order do
    # 商品部分
    user_id {1}
    item_id {1}

    # 支払い部分
    # price {3000}                               # "商品価格"
    token {"tok_abcdefghijk00000000000000000"} # "トークン番号"
    # number {4242424242424242}
    # exp_month {12}
    # exp_year  {24}
    # cvc       {123}

    # address部分
    postal_code   {"111-1111"}    # "郵便番号"
    prefecture_id {1}             # "配送先"
    city          {"大阪市"}       # "市区町村名"
    house_number  {"12345"}       # "丁目・番地・号"
    building_name {"aaa11"}       # "建物名"
    phone_number  {"09012345678"} # "電話番号"

    # アソシエーション
    # association :item
    # association :address
  end
end
