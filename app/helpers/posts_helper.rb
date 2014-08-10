module PostsHelper
  def current_user   #MAKE SURE TO SET session[:current] = CURRENT USER ID!!! DONE IN CONTROL
    @current_user ||= User.find_by(id: session[:id])
  end
  
  def last_five
  	@posts = Post.all.sort_by(&:updated_at).last(5).reverse
  end
  
end
