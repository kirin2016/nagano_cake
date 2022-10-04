class Public::GenresController < ApplicationController

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @item_selects = Item.where(genre_id: @genre.id, is_active: true)
    @items = @item_selects.page(params[:page]).per(12)
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price)
  end

end