class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
