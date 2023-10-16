class Customer::TagsController < ApplicationController
  
  def top
    @tags = Tag.all
  end

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.all
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end
  
  private

  def tags_params
    params.require(:tag).permit(:id, :tag_name)
  end
end