class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to public_posts_path
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.customer == current_customer
      render "edit"
    else
      redirect_to public_posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save
      redirect_to public_post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
