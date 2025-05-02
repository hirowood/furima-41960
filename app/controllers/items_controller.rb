class ItemsController < ApplicationController
<<<<<<< Updated upstream
<<<<<<< Updated upstream
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :user_product,       only: [:edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :prevent_own_item_purchase, only: [:edit]

=======
=======
>>>>>>> Stashed changes
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit]
>>>>>>> Stashed changes
  def index
    @items = Item.includes(:user).order(created_at: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :genre_id, :free_shopping_id, :delivery_day_id,
                                 :product_condition_id, :prefecture_id, :image).merge(user_id: current_user.id)
  end

  def user_product
    return if current_user.id == Item.find(params[:id]).user_id

    redirect_to root_path
  end

  def prevent_own_item_purchase
    @item = Item.find(params[:id])
    redirect_to root_path if @item.order.present?
  end
end
