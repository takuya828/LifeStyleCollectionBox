class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
     @q = User.ransack(params[:q])
     @users = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @posts = User.find(params[:id]).posts.page(params[:page]).per(4).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:success] = "You have updated info successfully."
       redirect_to  admin_user_path(@user.id)
    elsif @user.update(is_delete: true)
       flash[:success] = "You have updated status successfully."
      redirect_to admin_user_path(@user.id)
    else
       flash[:danger] = "error"
       redirect_to admin_user_path(@user.id)
    end
  end

  private

   def user_params
    params.require(:user).permit(:handle_name, :email, :is_delete)
   end
end
