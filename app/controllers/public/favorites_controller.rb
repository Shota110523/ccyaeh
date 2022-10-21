class Public::FavoritesController < ApplicationController
  def index
    @post = Post.find_by(params[:post_id])
    @favorite = current_customer.favorites.find_by(post_id: @post.id)
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.new(post_id: @post.id)
    @favorite.save
    #redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    #redirect_to request.referer
  end
end
