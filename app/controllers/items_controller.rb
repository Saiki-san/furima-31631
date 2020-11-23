class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :new, :edit]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @items = Item.all.order("created_at DESC") # .order("created_at DESC")id大きい順(最近出品順)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.valid? && @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if user_signed_in?
      if (current_user.id != @item.user.id) #|| (「もし選択した商品に紐づく購入記録が存在していたら（空ではなかったら）)
        redirect_to root_path
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private

  # def user_params
  #   params.permit(:nickname, :lastname, :firstname, :lastname_reading, :firstname_reading)
  # end

  # def address_params(user)
  #   params.permit(:postal_code, :prefecture, :city, :house_number, :building_name).merge(user_id: user.id)
  # end

  # def donation_params(user)
  #   params.permit(:price).merge(user_id: user.id)
  # end

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

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  # before_action :authenticate_user!, only: [:new]の記述により、下記は不要！！
  # before_action :move_to_session, only: [:new]
  # def move_to_session
  #   unless user_signed_in?
  #     redirect_to new_user_session_path
  #   end
  # end
end
