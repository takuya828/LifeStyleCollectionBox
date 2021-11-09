class UsersController < ApplicationController
  def show
     @user =  User.find(params[:id])
     @posts = current_user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "変更完了致しました。"
    redirect_to users_mypage_path(@user.id)
    else
       flash[:danger] = "変更完了できてません。"
       redirect_to users_mypage_path(@user.id)
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
end


  private
  def user_params
    params.require(:user).permit(:handle_name, :email, :is_delete, :image)
  end

end
