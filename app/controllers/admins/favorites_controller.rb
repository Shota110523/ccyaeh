class Admins::FavoritesController < ApplicationController
  def customer
    @favorites = Post.find(params[:post_id]).favorites
  end
end
