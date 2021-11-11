class PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      flash[:success3] = "コメント投稿完了！"
    redirect_to post_path(post)
    else
    flash[:danger] = "コメントが空白です"
    redirect_to post_path(post)
    end
  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

   private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
