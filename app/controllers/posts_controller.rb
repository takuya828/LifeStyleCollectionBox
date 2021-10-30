class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end
  
  def ranking
     @posts = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def ranking
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body, :category_id)
  end

end
