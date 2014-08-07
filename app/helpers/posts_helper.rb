module PostsHelper
  def current_user   #MAKE SURE TO SET session[:current] = CURRENT USER ID!!! DONE IN CONTROL
    @current_user ||= User.find_by(id: session[:id])
  end
end
