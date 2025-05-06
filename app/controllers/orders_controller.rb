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
    @address_order = AddressOrder.new(order_address_params)

    if @address_order.valid? && pay_item && @address_order.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      flash.now[:alert] ||= '入力内容を確認してください'
      render :index, status: :unprocessable_entity
    end
  end

  private

  # --- before_action ----
  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_payjp_public_key
    gon.public_key =
      Rails.application.credentials.dig(:payjp, :public_key) ||
      ENV['PAYJP_PUBLIC_KEY']
  end

  # --- params & payjp ----
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
    Payjp.api_key =
      Rails.application.credentials.dig(:payjp, :secret_key) ||
      ENV['PAYJP_SECRET_KEY']

    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
    true
  rescue Payjp::CardError => e
    Rails.logger.error("PayJP charge failed: #{e.message}")
    flash.now[:alert] = "カード決済に失敗しました: #{e.message}"
    false
  end

  def prevent_sold_item
    redirect_to root_path, alert: '売り切れ商品の購入はできません' if @item.order.present?
  end

  def prevent_own_item_purchase
    redirect_to root_path, alert: '自分の商品は購入できません' if current_user.id == @item.user_id
  end
end
