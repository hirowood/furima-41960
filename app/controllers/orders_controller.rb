class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :prevent_sold_item
  before_action :prevent_own_item_purchase
  before_action :set_payjp_public_key, only: %i[index create]

  def index
    @address_order = AddressOrder.new
  end

  def create
    @address_order = AddressOrder.new(order_address_params.merge(user_id: current_user.id, item_id: @item.id))

    if @address_order.valid?
      pay_item
      @address_order.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_payjp_public_key
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY')
  end

  # Strong Parameters
  def order_address_params
    params.require(:address_order).permit(
      :postal_code, :prefecture_id, :city, :house_number,
      :building_name, :phone_number, :token
    ).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY')
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:address_order][:token],
      currency: 'jpy'
    )
  end

  def prevent_sold_item
    return unless @item.order.present?

    redirect_to root_path, alert: 'この商品はすでに購入されています'
  end

  # 【追加】自分の商品に自分で購入ページへ来させない
  def prevent_own_item_purchase
    return unless @item.user_id == current_user.id

    redirect_to root_path, alert: '自分の商品は購入できません'
  end
end
