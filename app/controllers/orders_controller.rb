class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    order = order.new(order_prams)
    if order.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit.merge
  end
end
