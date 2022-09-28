class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @sum_item_price = 0
  end

  def create
    @genres = Genre.all
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       @cart_item.amount += params[:cart_item][:amount].to_i
       @cart_item.save
			 redirect_to cart_items_path, notice: "You have created item successfully."
    elsif @cart_item.save
      redirect_to cart_items_path, notice: "You have created item successfully."
    else
      redirect_to item_path(@cart_item.item_id)
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
