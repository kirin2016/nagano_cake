class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
