class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = User.find(params[:id]).posts
    @posts = @posts.page(params[:page]).per(8).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "変更完了致しました。"
      redirect_to user_path(@user.id)
    else
      flash[:danger] = "そのハンドルネームは既に利用されてます。もしくは ハンドルネーム、メールアドレスが空白です。"
      redirect_to edit_user_path(@user.id)
    end
  end

  def check
    @user = current_user
  end

  def quit
    @user = User.find(params[:id])
    @user.update(is_delete: true)
    reset_session
    flash[:notice] = "退会処理を完了致しました。"
    redirect_to root_path
  end

  def favorites
    @q = Post.ransack(params[:q])
    @user = User.find_by(id: params[:id])
    @favorites = Favorite.where(user_id: @user.id).reverse_order
    @favorites = @favorites.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:handle_name, :email, :is_delete, :image)
  end
end
