class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string         :name,                   null: false # 商品名
      # image                 | ActiveStorage  | null: false | 出品画像 ActiveStorageで実装する！ -->
      t.integer        :price,                  null: false # 販売価格
      t.text           :info,                   null: false # 商品の説明
      t.references     :user,                   null: false, foreign_key: true # 出品者名(item_seller_name, nickname)

      # 以下はactiveh_hashにて実装の為、integer型・語尾に_idとする
      t.integer        :category_id,            null: false # 商品の詳細(カテゴリー)
      t.integer        :sales_status_id,        null: false # 商品の詳細(sales status,商品の状態)
      t.integer        :shipping_fee_status_id, null: false # 配送について(配送料の負担)
      t.integer        :prefecture_id,          null: false # 配送について(shipping_prefecture,県,発送元の地域)
      t.integer        :scheduled_delivery_id,  null: false # 配送について(発送までの日数)(=scheduled delivery,発送予定日,発送日の目安)

      t.timestamps
    end
  end
end
