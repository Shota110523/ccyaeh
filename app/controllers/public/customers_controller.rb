class Public::CustomersController < ApplicationController
  before_action :set_user, :only => [:show, :favorites, :comments, :destroy]

  def show
    @customer = Customer.find(params[:id])
    if @customer.status == 'nonreleased' && @customer != current_customer
      respond_to do |format|
        format.html { redirect_to public_posts_path, notice: 'このページにはアクセスできません' }
      end
    end
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

  def release
    @customer = Customer.find(params[:customer_id])
    @customer.released! unless @customer.released?
    redirect_to edit_public_customer_path(@customer), notice: 'このアカウントを公開しました'
  end

  def nonrelease
    @customer = Customer.find(params[:customer_id])
    @customer.nonreleased! unless @customer.nonreleased?
    redirect_to edit_public_customer_path(@customer), notice: 'このアカウントを非公開にしました'
  end

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
