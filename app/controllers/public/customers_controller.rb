class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

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
      redirect_to customer_path(@customer.id)
    else
      flash.now[:danger] = 'エラーが発生し、変更できませんでした。'
      render :edit
    end
  end

  def unsubcribe
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました、ご利用ありがとうございました。"
    redirect_to root_path
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
