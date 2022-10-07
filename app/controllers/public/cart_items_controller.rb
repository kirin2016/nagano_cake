class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.page(params[:page]).per(5)
    @cart_items_total = current_customer.cart_items
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
       flash[:notice] = "#{@cart_item.item.name}はカートに登録済みの商品です。注文数を追加変更しました。"
			 redirect_to cart_items_path
    elsif @cart_item.save
      flash[:success] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to cart_items_path
    else
      flash[:warning] = '注文数を選択してください。'
      redirect_to item_path(@cart_item.item_id)
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:success] = "#{@cart_item.item.name}の注文数を変更しました。"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "#{@cart_item.item.name}を削除しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    if @cart_items.present?
      @cart_items.destroy_all
      flash[:success] = "カートの商品を全て削除しました。"
      redirect_to cart_items_path
    else
      flash[:warning] = 'カートは元々空です。'
      redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
