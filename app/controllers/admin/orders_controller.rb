class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @sum_item_price_purchase = 0
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    if @order.update(order_params)
      flash[:success] = '注文ステータスを更新しました。'
      if @order.order_status == Order.order_statuses.key(1)
        @order_details.each do |order_detail|
          order_detail.create_status = OrderDetail.create_statuses.key(1)
          order_detail.save
          flash[:notice] = '製作ステータスが変更されました。'
        end
      end
      redirect_to admin_order_path(@order.id)
    else
      flash.now[:danger] = 'エラーが発生し、更新できませんでした。'
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end

