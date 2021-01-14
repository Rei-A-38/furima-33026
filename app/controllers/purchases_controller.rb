class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: [:index,:create]
  
  def index
    # @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.purchase != nil
       redirect_to root_path
    end
    # return redirect_to root_path if current_user.id == @item.user_id || @item.purchase != nil
    @user_purchase = UserPurchase.new
  end

  def create
    # @item = Item.find(params[:item_id])
    @user_purchase = UserPurchase.new(purchase_params)  
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.permit(:item_id,:postal_code, :prefecture_id, :city, :house_number, :phone_number).merge(user_id: current_user.id)
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end
end
