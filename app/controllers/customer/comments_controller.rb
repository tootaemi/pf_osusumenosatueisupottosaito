class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @comment = current_customer.comments.new(comment_params)
    @post = @comment.post
    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = @post.comments.includes(:customer)
      render "customer/posts/show"
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment)
  end
end