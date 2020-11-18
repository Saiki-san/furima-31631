class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]
  def index
    # @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    # user = User.create(user_params)
    # Address.create(address_params(user))
    # Donation.create(donation_params(user))
    # redirect_to action: :index
  end

  def show
  end

  def edit
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
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
      :item_name,              :item_price,                 :item_info,
      :item_category_id,       :item_condition_id,          :shipping_fee_burden_id,
      :shipping_prefecture_id, :scheduled_shipping_date_id, :item_image
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
