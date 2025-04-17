class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @address_order = AddressOrder.new
  end

  def create
    @address_order = Address.new(order_address_params)
    if @address_order.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:id])
  end
end
