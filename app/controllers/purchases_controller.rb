class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: [:index,:create]
  
  def index
    # @item = Item.find(params[:item_id]) # 復習用に残しているコードです
    if current_user.id == @item.user_id || @item.purchase != nil
       redirect_to root_path
    end
    # return redirect_to root_path if current_user.id == @item.user_id || @item.purchase != nil #復習用に残しているコードです
    @user_purchase = UserPurchase.new
  end

  def create
    # @item = Item.find(params[:item_id]) # 復習用に残しているコードです
    @user_purchase = UserPurchase.new(purchase_params)  
    if @user_purchase.valid?
      pay_item
      @user_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :prefecture_id, :city, :building_name,:house_number, :phone_number).merge(user_id: current_user.id,token: params[:token],item_id: @item.id)
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_3dc4083e196f83afad103ff1"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end

end
