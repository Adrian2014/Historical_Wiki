class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = session[:id]

    if @user.save
      session[:id] = @user.id
      redirect_to users_show_path
    else
      render :new
    end
  end


  private
  def comment_params
    params.require(:post).permit(:comment_id, :post_id)
  end

end