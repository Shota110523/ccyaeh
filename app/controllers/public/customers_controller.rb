class Public::CustomersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

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

  def favorites
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def confirm
  end

  def withdraw
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :body, :profile_image)
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "GUEST"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
