class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).reverse_order
    @posts = @posts.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "変更完了致しました。"
      redirect_to admin_post_path
    else
      @post = Post.find(params[:id])
      flash[:danger] = "タイトルまたは内容が空白です。"
      redirect_to edit_admin_post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:id, :title, :body, :image, :category_id)
  end
end
