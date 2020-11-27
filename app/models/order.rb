class Order < ApplicationRecord
  # アソシエーション
  belongs_to :item # 1回の購入記録は、1つの商品につき1カウントだけ
  belongs_to :user # 1回の購入記録は、1人のユーザーによってカウントされる
  has_one    :address # 1回の購入記録は、1つの配送先(has_one親)

  # バリデーション
  # 無し

end