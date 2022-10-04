class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = Address.all.page(params[:page]).per(5)
    @address = Address.new
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = '新規の送り先を登録しました。'
      redirect_to addresses_path
    else
      flash.now[:danger] = 'エラーが発生し、登録できませんでした。'
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = '送り先の情報を変更しました。'
      redirect_to addresses_path
    else
      flash.now[:danger] = 'エラーが発生し、変更できませんでした。'
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:success] = '送り先を削除しました。'
    redirect_to addresses_path
  end


  private

  def address_params
    params.require(:address).permit(:name,
      :postal_code,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building,
      )
  end

end
