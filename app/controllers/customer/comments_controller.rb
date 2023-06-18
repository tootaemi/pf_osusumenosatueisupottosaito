class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!

    def create
      post = Post.find(params[:post_id])
          comment = current_customer.comments.new(post_comment_params)

      # comment = current_customer.comments.new(comment_params)
      comment.post_id = post.id
      comment.save
      redirect_to post_path(post)
    # post_image = PostImage.find(params[:post_image_id])
    # comment.post_image_id = post_image.id
    # comment.save
    # redirect_to post_image_path(post_image)
    end
    
    def destroy
      Comment.find(params[:id]).destroy
      redirect_to post_path(params[:post_id])
    end

  private
    def post_comment_params
      params.require(:comment).permit(:id, :customer_id, :post_id, :comment)
    end
    
end