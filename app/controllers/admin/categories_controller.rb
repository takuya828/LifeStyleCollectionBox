class Admin::CategoriesController < ApplicationController
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
       flash[:success] = "ジャンル名変更されました。"
       redirect_to admin_categories_path
    else
       render 'edit'
    end
  end

   private
  def category_params
    params.require(:category).permit(:name)
  end
  
end
