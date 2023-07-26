class Admin::CommentsController < ApplicationController
    def index
      @comments = Comment.all
      @comment = Comment.new
      @customers = Customer.all
      @customer = Customer.new
      @posts = Post.all
      @post = Post.new
      @comments = Comment.all.page(params[:page]).per(10)
    end
    
    def show
      @comment = Comment.find(params[:id])
      @customer = @comment.customer
    end

    def create
      @comment = current_customer.comments.new(comment_params)
      if @comment.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
    end
    
    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      @comment = comment.post
        redirect_to admin_comments_path(@comments)
    end

    private
    def comment_params
      params.require(:comment).permit(:customer_id, :post_id, :comment)
    end

end