class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create] # authenticate_user!メソッドは、未ログインユーザーをログインフォームに遷移させる！
  before_action :set_item, only: [:index, :create] # createした瞬間に@itemの情報がnilになってしまう(仕様)ので、再定義
  def index
    if @item.order || current_user.id == @item.user_id
      redirect_to root_path
    end
    @token_address_order = TokenAddressOrder.new
  end

  def create
    @token_address_order = TokenAddressOrder.new(token_address_order_params)
    if @token_address_order.valid?
      pay_item
      @token_address_order.save # フォームオブジェクトのsaveメソッド！(ついでにorderもcreateする)
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def token_address_order_params # 保存許可！
    params.require(:token_address_order).permit(
      :postal_code, :prefecture_id,
      :city, :house_number,
      :building_name, :phone_number
    ).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    ) # mergeでuser_idとitem_id追加(saveメソッドでorderのテーブル作成時に必要)。tokenはJavaScriptで取得後、決済に必要
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段。amountには、実際に決済する金額が入ります。
        card: token_address_order_params[:token],    # カードトークン。cardには、トークン化されたカード情報が入ります。
        currency: 'jpy' # 通貨の種類（日本円）。currencyには取引に使用する通貨の種類を記述（今回は日本円を指定）。
      )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end