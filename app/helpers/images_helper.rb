module ImagesHelper

  def images 
  	@images=[] 
  	 
  	last_five.each do |post|
  	 @images << post.image
  	end

  end 

end