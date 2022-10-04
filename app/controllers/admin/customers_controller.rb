class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = 'お客様情報を変更しました。'
      redirect_to admin_customer_path(@customer.id)
    else
      flash.now[:warning] = '必須項目に誤りがあります。必要情報を正しく入力してください。'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building,
      :telephone_number,
      :email,
      :is_deleted,)
  end

end
