class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @category = Category.new
  end

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to admin_categories_path
  end

  def edit
    @category = Category.find(params[:id])
    render "edit"
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "カテゴリー名が変更されました。"
      redirect_to admin_categories_path
    else
      flash[:danger] = "カテゴリー名が空白です。"
      render 'edit'
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
