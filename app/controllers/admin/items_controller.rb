class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "#{@item.name}を新規登録しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:danger] = 'エラーが発生し、登録できませんでした。'
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = '変更を保存しました。'
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:warning] = '必須項目に誤りがあります。必要情報を正しく入力してください。'
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end

end
