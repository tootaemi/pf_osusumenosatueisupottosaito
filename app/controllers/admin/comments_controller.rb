class Admin::CommentsController < ApplicationController

def index
    @comments = Comment.all
    @comment = Comment.new
    @customers = Customer.all
    @customer = Customer.new
    @posts = Post.all
    @post = Post.new
    #@comments = Comment.page(params[:page]).per(10)
    @comment = Comment.all.order("created_at DESC")
end







  private
    def post_comment_params
      params.require(:comment).permit(:id, :customer_id, :post_id, :comment)
    end


end