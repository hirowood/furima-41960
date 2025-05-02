# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :prevent_sold_item
  before_action :prevent_own_item_purchase

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @address_order = AddressOrder.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @address_order = AddressOrder.new(order_address_params)
    if @address_order.valid?
      pay_item
      if @address_order.save
        redirect_to root_path
      else
        gon.public_key = ENV['PAYJP_PUBLIC_KEY']
        render :index, status: :unprocessable_entity
      end
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
    params.require(:address_order).permit(
      :postal_code, :prefecture_id, :city, :house_number,
      :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end

  def prevent_sold_item
    redirect_to root_path if @item.order.present?
  end

  def prevent_own_item_purchase
    redirect_to root_path if current_user.id == @item.user_id
  end
end
