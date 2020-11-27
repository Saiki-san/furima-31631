class TokenAddressOrder
  # 設定
  include ActiveModel::Model # Formオブジェクト化する
  # attr_accessor:テーブルにないカラムにバリデーションをかけられるように、カラム名を指定
  attr_accessor  :user_id, :item_id, :token, :price, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number
  extend ActiveHash::Associations::ActiveRecordExtensions # ActiveHash使用の為、記述(prefecture(配送先の県))

  # アソシエーション
  # 無し

  # バリデーション
  with_options presence: true do # 〜endまでは、空欄禁止
    validates :item_id
    validates :user_id
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"} # "数字3つ + 「-」 + 数字4つ"
    validates :prefecture_id, numericality: { other_than: 0, message: "Select" } # 配送先の県 # idが0は禁止(---除外)
    validates :city
    validates :house_number
    # validates :building_name # 建物名はバリデーション不要(空欄可)
    validates :phone_number, numericality: { only_integer: true, message: "Input only number"}, # 整数のみ可能
                              length:      { in: 10..11, message: "Out of setting range"} # (数字が)10こ又は11この時だけ可
  end

  # validates :phone_number, numericality: { length: { maximum: 11 }, message: "Out of setting range"} # (数字が)11こ以下の時だけ可

  def save # 保存時のメソッド。(.createは、生成 & 保存！)
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create( # 住所の情報を保存
      postal_code: postal_code, prefecture_id: prefecture_id,
      city: city, house_number: house_number,
      building_name: building_name, phone_number: phone_number, order_id: order.id
    )
  end
end

# メモ
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