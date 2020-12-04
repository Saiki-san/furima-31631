require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '#new, create(商品出品機能)' do
    context '出品がうまくいくとき' do
      it "nameとprice、info、image、category_id、sales_status_id、
          shipping_fee_status_id、prefecture_id、scheduled_delivery_id、user_id
          が存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it "nameが空だと登録できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください") # "Name can't be blank"
      end
      it "priceが空だと登録できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください") # "Price can't be blank"
      end
      it "priceが全角数字だと登録できない" do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力して下さい") # "Price Half-width number"
      end
      it "priceが半角英字だと登録できない" do
        @item.price = 'price'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力して下さい") # "Price Half-width number"
      end
      it "priceが300未満だと登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は¥300~9,999,999の範囲で設定して下さい") # "Price Out of setting range"
      end
      it "priceが1000万以上だと登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は¥300~9,999,999の範囲で設定して下さい") # "Price Out of setting range"
      end
      it "infoが空だと登録できない" do
        @item.info = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください") # "Info can't be blank"
      end
      it "imageが空だと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください") # "Image can't be blank"
      end
      it "category_idが空だと登録できない" do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択して下さい") # "Category Select"
      end
      it "category_idが0(---)だと登録できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択して下さい") # "Category Select"
      end
      it "sales_status_idが空だと登録できない" do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択して下さい") # "Sales status Select"
      end
      it "sales_status_idが0(---)だと登録できない" do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択して下さい") # "Sales status Select"
      end
      it "shipping_fee_status_idが空だと登録できない" do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択して下さい") # "Shipping fee status Select"
      end
      it "shipping_fee_status_idが0(---)だと登録できない" do
        @item.shipping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択して下さい") # "Shipping fee status Select"
      end
      it "prefecture_idが空だと登録できない" do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択して下さい") # "Prefecture Select"
      end
      it "prefecture_idが0(---)だと登録できない" do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択して下さい") # "Prefecture Select"
      end
      it "scheduled_delivery_idが空だと登録できない" do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択して下さい") # "Scheduled delivery Select"
      end
      it "scheduled_delivery_idが0(---)だと登録できない" do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択して下さい") # "Scheduled delivery Select"
      end
      it "ユーザーが紐付いていないとitemは登録できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください") # "User must exist"
      end
    end
  end
end

# bundle exec rspec spec/models/item_spec.rb