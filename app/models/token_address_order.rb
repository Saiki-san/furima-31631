class TokenAddressOrder
  # 設定
  # Formオブジェクト化する
  include ActiveModel::Model
  # テーブルにないカラムにバリデーションをかけられるように、attr_accessorでカラムを指定
  attr_accessor  :user_id, :item_id, :token, :price, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーション
  # 無し

  # バリデーション
  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"} # "is invalid. Include hyphen(-)"
    validates :prefecture_id, numericality: { other_than: 0, message: "Select" } # 配送について(発送先の地域) # idが0以外(---除外)
    validates :city
    validates :house_number
    # validates :building_name # 建物名はバリデーション不要(空欄可)
    validates :phone_number, numericality: { only_integer: true, message: "Input only number"} # 整数のみ(string縛りで使えるか。。。)
  end
  validates :phone_number, numericality: { length: { in: 10..11 }, message: "Out of setting range"} # 整数のみ(string縛りで使えるか。。。)

  def save
    # ユーザーの情報を保存し、「user」という変数に入れている
    # user = User.create(name: name, name_reading: name_reading, nickname: nickname)
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    Address.create(
      postal_code: postal_code, prefecture_id: prefecture_id,
      city: city, house_number: house_number,
      building_name: building_name, phone_number: phone_number, order_id: order.id
    )
  end
end

# あるクラスにActiveModel::Modelをincludeすると、
# そのクラスのインスタンスはActiveRecordを継承したクラスのインスタンスと同様に
# form_with や render などのヘルパーメソッドの引数として扱えたり、
# バリデーションの機能が使えるようになります。
# Formオブジェクトパターンを実装するために
# ActiveModel::Modelをincludeしたクラスのことを「Formオブジェクト」と呼ぶこともあります。

# attr_accessorを活用
# 今回のフォームで利用する全ての属性(つまり、保存したい各テーブルのカラム名全て)について
# ゲッターとセッターを定義することで、このFormオブジェクトのインスタンスを生成した際に
# form_withの引数として利用できるようになります。