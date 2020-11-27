class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order("created_at DESC") # .order("created_at DESC")id大きい順(最近出品順)
    # @items = Item.includes(:order).order("created_at DESC") → モデル名.includes(:紐付くモデル名) N+1だと紐付いていないとき、エラーが発生する(メモ)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid? && @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if (current_user.id != @item.user.id) || @item.order # もし選択した商品に紐づく購入記録が存在していたら（空ではなかったら)
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user.id
      @item.destroy
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :name,          :price,                 :info,
      :category_id,   :sales_status_id,       :shipping_fee_status_id,
      :prefecture_id, :scheduled_delivery_id, :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
