class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all.page(params[:page]).reverse_order
  end

  def show
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id: @customer.id).page(params[:page]).reverse_order
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
