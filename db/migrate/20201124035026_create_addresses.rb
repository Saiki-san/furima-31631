class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string     :postal_code,   default: "", null: false # 郵便番号
      t.integer    :prefecture_id,              null: false # 配送について(shipping_prefecture,県,発送元の地域)
      t.string     :city,          default: "", null: false # 市区町村
      t.string     :house_number,  default: "", null: false # 丁目、番地、号
      t.string     :building_name, default: ""              # 建物名
      t.string     :phone_number,  default: "", null: false # 電話番号
      t.references :order,                      null: false, foreign_key: true # 購入記録と紐付け

      t.timestamps
    end
  end
end
