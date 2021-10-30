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
    @posts = Post.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def search
    @q = Post.ransack(params[:q])
    selection = params[:keyword]
    @posts = Post.sort(selection)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body, :category_id)
  end

end