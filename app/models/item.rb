class Item < ApplicationRecord
  # アソシエーション
  belongs_to :user             # 1つの(出品された)商品は、1人のユーザーによって出品される
  has_one    :order            # 1つの(出品された)商品は、1つの購入記録
  has_one_attached :image      # 1つの(出品された)商品は、1つの商品画像をもつ

  extend ActiveHash::Associations::ActiveRecordExtensions # ActiveHashを用いて、belongs_toを設定。module取り込み
  belongs_to :prefecture          # 1つの(出品された)商品は、1つの住所(発信元・配送先)
  belongs_to :category            # 1つの(出品された)商品は、1つのカテゴリー
  belongs_to :sales_status        # 1つの(出品された)商品は、1つの商品状態
  belongs_to :shipping_fee_status # 1つの(出品された)商品は、1つの配送料負担
  belongs_to :scheduled_delivery  # 1つの(出品された)商品は、1つの配送予定日

  # バリデーション
  with_options presence: true do
    validates :name                    # 商品名
    validates :price, numericality: { only_integer: true, message: "は半角数字で入力して下さい"} # 販売価格(数字のみ。少数不可) "Half-width number"
    validates :info                    # 商品の説明
    # validate :user ← 自動
    validates :image                    # 商品画像
    with_options numericality: { other_than: 0, message: "を選択して下さい" } do # idが0以外(---除外) "Select"
      validates :category_id            # 商品の詳細(カテゴリー)
      validates :sales_status_id        # 商品の詳細(商品の状態)
      validates :shipping_fee_status_id # 配送について(配送料の負担)
      validates :prefecture_id          # 配送について(shipping_prefecture,県,発送元の地域)
      validates :scheduled_delivery_id  # 配送について(発送までの日数)(=scheduled delivery,発送予定日,発送日の目安)
    end
  end
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は¥300~9,999,999の範囲で設定して下さい"} # 販売価格(300<=●<=999万9999) "Out of setting range"

  # def was_attached?
  #   self.image.attached?
  # end
end
