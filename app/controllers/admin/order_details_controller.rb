class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    @check_number = 0
    if @order_detail.update(order_detail_params)
      flash[:success] = '製作ステータスを更新しました。'
      if @order_detail.create_status == OrderDetail.create_statuses.key(2)
        if @order.order_status == Order.order_statuses.key(1)
          @order.order_status = Order.order_statuses.key(2)
          @order.save
          flash[:notice] = '注文ステータスが変更されました。'
        end
      elsif @order_detail.create_status == OrderDetail.create_statuses.key(3)
        @order_details.each do |order_detail|
          unless order_detail.create_status == OrderDetail.create_statuses.key(3)
            @check_number += 1
          end
        end
        if @check_number == 0
          @order.order_status = Order.order_statuses.key(3)
          @order.save
          flash[:notice] = '注文ステータスが変更されました。'
        end
      end
      redirect_to admin_order_path(@order_detail.order_id)
    else
      flash.now[:danger] = 'エラーが発生し、更新できませんでした。'
      render :show
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:create_status)
  end

end
