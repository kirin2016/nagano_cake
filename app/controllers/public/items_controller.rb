class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all
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
