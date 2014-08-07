class CommentsController < ApplicationController

  # GET /comment/new
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = session[:id]
    @comment.post_id = params[:id]

    if @comment.save
      redirect_to  "/posts/#{@comment.post_id}"
    else


    end
  end


  private
  def comment_params
    params.require(:comment).permit(:comment_text)
  end

end
