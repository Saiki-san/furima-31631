class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user,    null: false, foreign_key: true # ユーザー情報と紐付け
      t.references :item,    null: false, foreign_key: true # 商品情報と紐付け
      t.timestamps
    end
  end
end
