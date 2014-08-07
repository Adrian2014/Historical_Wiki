class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:id] = @user.id
      redirect_to users_show_path
    else
      render :new
    end
  end

  def show
    @posts = Post.find_by(user_id: session[:id])
  end

  def login
    @user = User.new
    render :login
  end


  def login_post
    data = params[:data]
    @user = User.find_by(email: data[:email])
    auth = user.try(:authenticate, data[:password])

    if auth
      session[:id] = user.id
      redirect_to '/'
    else
      # flash[:error] = "Invalid email/password. Please try again!"
      render :login
    end
  end



  def logout
    session[:id] = nil
    redirect_to '/'
  end

  private
  def user_params
    params.require(:post).permit(:username, :email, :password, :password_confirmation)
  end

end
