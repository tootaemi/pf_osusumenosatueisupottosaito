class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!
  # skip_before_action :set_post, only: :destroy

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
      comment_url(id: params[:id],post_id: params[:post_id])
      redirect_to posts_path(@post)
      
      comment = Comment.find(params[:id])
      @post = comment.post
      comment.destroy!
      # redirect_to posts_path(post), alert: 'コメントを削除しました'

      # Comment.find(params[:id]).destroy
      session.delete(:how_to_pay)
      #Comment.where(comment_id: current_customer).delete_all
      #redirect_to comment_path(params[:comment_id])
    end

  private
    def post_comment_params
      params.require(:comment).permit(:id, :customer_id, :post_id, :comment)
    end
end


