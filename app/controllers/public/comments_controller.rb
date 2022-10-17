class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to public_post_path(@post.id)
  end

  def destroy
    @comment = Comment.find_by(params[:comment_id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
