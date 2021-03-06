class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :destroy, :update]

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿完了致しました。"
      redirect_to user_path(@user)
    else
      flash[:danger] = "カテゴリー選択、タイトルまたは内容が空白です。"
      render :new
    end
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).reverse_order
    @posts = @posts.page(params[:page]).per(10)
  end

  def ranking
    @q = Post.ransack(params[:q])
    @posts = Post.left_joins(:favorites).group(:id).order(Arel.sql('count(favorites.post_id) desc'))
  end

  def search
    @q = Post.ransack(params[:q])
    selection = params[:keyword]
    @posts = Post.sort(selection)
  end

  def rank
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).left_joins(:favorites).group(:id).order(Arel.sql('count(favorites.post_id) desc'))
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "編集完了致しました。"
      redirect_to post_path
    else
      @post = Post.find(params[:id])
      flash[:danger] = "タイトルまたは内容が空白です。"
      render :edit
    end
  end

  def destroy
    @user = current_user
    post = Post.find(params[:id])
    post.destroy
    flash[:success2] = "削除完了致しました。"
    redirect_to user_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body, :category_id)
  end

  def baria_user
    unless Post.find(params[:id]).user.id.to_i == current_user.id
      redirect_to posts_path
    end
  end

end
