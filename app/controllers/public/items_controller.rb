class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @item_selects = Item.where(is_active: true)
    @items = @item_selects.page(params[:page]).per(12)
  end

  def show
    @genres = Genre.all
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price)
  end

end
