class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!
  # skip_before_action :set_post, only: :destroy



  def create
    @comment = current_customer.comments.new(comment_params)
    @post = @comment.post
    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = @post.comments.includes(:customer)
      render 'customer/posts/show'
    end
      # redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
  end
    



  # def create
  #   @comment
  #   redirect_to post_url

  #     post = Post.find(params[:post_id])
  #     comment = current_customer.comments.new(post_comment_params)
  #     comment.post_id = post.id
   

    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
    
      # comment_url(id: params[:id],post_id: params[:post_id])
      # redirect_to posts_path(@post)
      
      @post = comment.post
      redirect_to post_path(@post)#, alert: 'コメントを削除しました'

      # Comment.find(params[:id]).destroy
      # session.delete(:how_to_pay)
      #Comment.where(comment_id: current_customer).delete_all
      #redirect_to comment_path(params[:comment_id])
    end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :comment)
    end
end
