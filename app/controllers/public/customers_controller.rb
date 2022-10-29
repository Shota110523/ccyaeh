class Public::CustomersController < ApplicationController
  before_action :set_user, :only => [:show, :favorites, :comments, :destroy]

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_customer_path(@customer.id)
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

# 　def withdraw
#     @customer = current_customer
#     # is_deletedカラムをtrueに変更することで削除フラグを立てる
#     @customer.update(is_deleted: true)
#     reset_session
#     flash[:notice] = "退会処理を実行いたしました"
#     redirect_to root_path
#   end

  private

  def customer_params
    params.require(:customer).permit(:name, :body, :profile_image)
  end

  def set_user
    @customer = Customer.find_by(:id => params[:id])
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "GUEST"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
