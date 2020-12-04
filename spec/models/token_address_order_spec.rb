require 'rails_helper'

RSpec.describe TokenAddressOrder, type: :model do
  before do
    @order = FactoryBot.build(:token_address_order)
  end

  describe '#create(購入機能)' do
    context '購入がうまくいくとき' do
      it "item_id, user_id, token、postal_code、prefecture_id、city、
        house_number、building_number、phone_number、が存在すれば登録できる" do
        expect(@order).to be_valid
      end
    end

    context '購入がうまくいかない' do
      it "item_idが空では登録できないこと" do
        @order.item_id = ""
        @order.valid?
        expect(@order.errors.full_messages).to include("Itemを入力してください") # "Item can't be blank"
      end

      it "user_idが空では登録できないこと" do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Userを入力してください") # "User can't be blank"
      end

      it "トークン(token)が空では登録できないこと" do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("カード情報を入力してください") # "Token can't be blank"
      end

      # it "クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと" do
        # @order.number    = nil
        # @order.exp_month = nil
        # @order.exp_year  = nil
        # @order.cvc       = nil
        # @order.valid?
        # expect(@order.errors.full_messages).to include("Token can't be blank")
      # end

      # it "配送先の住所情報も購入の都度入力させること" do
      # end

      # it "配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること" do
      # end

      it "郵便番号(postal_code)にはハイフン( - )が必要であること(123-4567の形とならなければならない)" do
        @order.postal_code = "1234567"
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号はハイフンを含む数字7桁で入力して下さい") # "Postal code Input correctly"
      end

      it "郵便番号(postal_code)にはハイフン( - )が必要で、始めが3桁でないと不可であること(123-4567の形とならなければならない)" do
        @order.postal_code = "12-3456"
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号はハイフンを含む数字7桁で入力して下さい") # "Postal code Input correctly"
      end

      it "郵便番号(postal_code)にはハイフン( - )が必要で、終わりが4桁でないと不可であること(123-4567の形とならなければならない)" do
        @order.postal_code = "123-45678"
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号はハイフンを含む数字7桁で入力して下さい") # "Postal code Input correctly"
      end

      it "郵便番号(postal_code)が空では購入できない" do
        @order.postal_code = ""
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号を入力してください") # "Postal code can't be blank"
      end

      it "都道府県(prefecture_id)が空では購入できない" do
        @order.prefecture_id = ""
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を選択して下さい") # "Prefecture Select"
      end

      it "都道府県(prefecture_id)が0(---)だと登録できない" do
        @order.prefecture_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を選択して下さい") # "Prefecture Select"
      end

      it "市区町村(city)が空では購入できない" do
        @order.city = ""
        @order.valid?
        expect(@order.errors.full_messages).to include("市区町村を入力してください") #
      end

      it "番地(house_number)が空では購入できない" do
        @order.house_number = ""
        @order.valid?
        expect(@order.errors.full_messages).to include("番地を入力してください") # "House number can't be blank"
      end

      it "電話番号(phone_number)が空では購入できない" do
        @order.phone_number = ""
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号を入力してください") # "Phone number can't be blank"
      end

      it "電話番号(phone_number)が数字以外の文字やハイフン( - )が含まれていると購入できない" do
        @order.phone_number = "123-4567890"
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は半角数字で入力して下さい") # "Phone number Input only number"
      end

      it "電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）" do
        @order.phone_number = "123456789000"
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は10又は11桁の数値で入力して下さい") # "Phone number Out of setting range"
      end

      it "電話番号にはハイフンは不要で、10桁以上であること（0612345678となる）" do
        @order.phone_number = "123456789"
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は10又は11桁の数値で入力して下さい") # "Phone number Out of setting range"
      end

      # ここから下は、システム(system・結合)
      # it "商品購入ページでは、一覧や詳細ページで選択した商品の情報が出力されること" do
      #   # expect(@order).to be_valid
      # end

      # it "ログアウト状態のユーザーは、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移すること" do
      #   # expect(@order).to be_valid
      # end

      # it "ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移すること" do
      #   # @order.price = nil
      #   # @order.valid?
      #   # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移すること" do
      #   # @order.price = nil
      #   # @order.valid?
      #   # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "購入が完了したら、トップページまたは購入完了ページに遷移すること" do
      #   # @order.price = nil
      #   # @order.valid?
      #   # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "エラーハンドリングができていること（適切では無い値が入力された場合、情報は保存されず、エラーメッセージを出力させること）" do
      #   # @order.price = nil
      #   # @order.valid?
      #   # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "入力に問題がある状態で購入ボタンが押されたら、購入ページに戻りエラーメッセージが表示されること" do
      #   # @order.price = nil
      #   # @order.valid?
      #   # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "クレジットカード決済ができること" do
        # @order.price = nil
        # @order.valid?
        # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "クレジットカードの情報は購入の都度入力させること" do
        # @order.price = nil
        # @order.valid?
        # expect(@order.errors.full_messages).to include("Price can't be blank")
      # end

      # it "priceとtokenがあれば保存ができること" do
      #   expect(@order).to be_valid
      # end

      # it "priceが空では登録できないこと" do
      #   @order.price = nil
      #   @order.valid?
      #   expect(@order.errors.full_messages).to include("Price can't be blank")
      # end
    end
  end
end

# bundle exec rspec spec/models/token_address_order_spec.rb