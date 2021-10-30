class Admin::PostsController < ApplicationController
  def index
     @q = Post.ransack(params[:q])
     @posts = @q.result(distinct: true)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
   @post = Post.find(params[:id])
  end


  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

end
