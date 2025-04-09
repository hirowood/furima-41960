class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
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
                                 :product_condition_id, :prefecture_id).merge(user_id: current_user_id)
  end
end
