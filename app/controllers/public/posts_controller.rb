class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all#.order(created_at: :desc)
    #@customer = Customer.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.save!
    redirect_to public_posts_path
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :customer_id)
  end
end
