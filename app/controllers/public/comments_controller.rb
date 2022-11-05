class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    #redirect_to public_post_path(@post.id)
    if @comment.save
    #通知の作成
      @post.create_notification_comment!(current_customer, @comment.id)
      #render :index
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    @comment = Comment.new
    #redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
