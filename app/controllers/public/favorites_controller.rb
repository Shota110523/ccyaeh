class Public::FavoritesController < ApplicationController
  def index
  end

  def customer
    @favorites = Post.find(params[:post_id]).favorites
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.new(post_id: @post.id)
    @favorite.save
    #redirect_to request.referer
    #通知の作成
    @post.create_notification_by(current_customer)
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    #redirect_to request.referer
  end
end
