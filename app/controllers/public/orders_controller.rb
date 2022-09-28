class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @orders = current_customer.orders.all
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.amount = cart_item.amount
        @order_detail.price_purchase = cart_item.item.add_tax_price
        @order_detail.save
      end
      redirect_to thanks_orders_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @cart_items = CartItem.all
    @sum_item_price = 0

    if order_params[:payment].nil?
      flash[:danger] = "支払い方法を入力してください"
      render :new
    else

      if params[:order][:selected_address] == "1"
        @order.postal_code_item = current_customer.postal_code
        @order.prefecture_code_item = current_customer.prefecture_code
        @order.address_city_item = current_customer.address_city
        @order.address_street_item = current_customer.address_street
        @order.address_building_item = current_customer.address_building
        @order.name_item = current_customer.last_name + current_customer.first_name


      elsif params[:order][:selected_address] == "2"
        if params[:order][:address_id] == ""
          flash[:danger] = "登録済み住所を選択してください"
          render :new
        else
          @address = Address.find(params[:order][:address_id])
          @order.postal_code_item = @address.postal_code
          @order.prefecture_code_item = @address.prefecture_code
          @order.address_city_item = @address.address_city
          @order.address_street_item = @address.address_street
          @order.address_building_item = @address.address_building
          @order.name_item = @address.name
        end

      elsif params[:order][:selected_address] == "3"
        @order.postal_code_item = order_params[:postal_code_item]
        @order.prefecture_code_item = order_params[:prefecture_code_item]
        @order.address_city_item = order_params[:address_city_item]
        @order.address_street_item = order_params[:address_street_item]
        @order.address_building_item = order_params[:address_building_item]
        @order.name_item = order_params[:name_item]
        @address = Address.new
        @address.customer_id = current_customer.id
        @address.postal_code = order_params[:postal_code_item]
        @address.prefecture_code = order_params[:prefecture_code_item]
        @address.address_city = order_params[:address_city_item]
        @address.address_street = order_params[:address_street_item]
        @address.address_building = order_params[:address_building_item]
        @address.name = order_params[:name_item]
        if @address.save
          flash[:success] = "新しいお届け先が保存されました"
        else
          flash[:danger] = "新しいお届け先の情報を正しく入力してください"
          render :new
        end
      else
        flash[:danger] = "必要情報を入力してください"
        render :new
      end
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @sum_item_price_purchase = 0
  end

  def thanks
  end


  private

  def order_params
    params.require(:order).permit(:id,
    :customer_id,
    :postal_code_item,
    :prefecture_code_item,
    :address_city_item,
    :address_street_item,
    :address_building_item,
    :name_item,
    :postage,
    :payment,
    :total_amount)
  end

end
