require 'rails_helper'

RSpec.describe TokenAddressOrder, type: :model do
  before do
    @order = FactoryBot.build(:token_address_order)
  end

  it "商品購入ページでは、一覧や詳細ページで選択した商品の情報が出力されること" do
    # expect(@order).to be_valid
  end

  it "ログアウト状態のユーザーは、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移すること" do
    # expect(@order).to be_valid
  end

  it "ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移すること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移すること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "クレジットカード決済ができること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "クレジットカードの情報は購入の都度入力させること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  # it "priceとtokenがあれば保存ができること" do
  #   expect(@order).to be_valid
  # end

  # it "priceが空では登録できないこと" do
  #   @order.price = nil
  #   @order.valid?
  #   expect(@order.errors.full_messages).to include("Price can't be blank")
  # end

  it "tokenが空では登録できないこと" do
    @order.token = nil
    @order.valid?
    expect(@order.errors.full_messages).to include("Token can't be blank")
  end

  it "クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "配送先の住所情報も購入の都度入力させること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "郵便番号にはハイフンが必要であること（123-4567となる）" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "購入が完了したら、トップページまたは購入完了ページに遷移すること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "エラーハンドリングができていること（適切では無い値が入力された場合、情報は保存されず、エラーメッセージを出力させること）" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end

  it "入力に問題がある状態で購入ボタンが押されたら、購入ページに戻りエラーメッセージが表示されること" do
    # @order.price = nil
    # @order.valid?
    # expect(@order.errors.full_messages).to include("Price can't be blank")
  end
end
