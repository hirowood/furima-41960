class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    # @item = current_user.items.build(item_params)
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :genre_id, :free_shopping_id, :delivery_day_id,
                                 :product_condition_id, :prefecture_id, :image).merge(user_id: current_user.id)
  end
end
