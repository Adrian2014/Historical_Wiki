class TagsController < ApplicationController

  def search
  	@tag = Tag.find_by(tag_slug: params[:tag][:tag_slug])
  	if @tag != nil
  		redirect_to "/tags/#{@tag.tag_text}"
  	else
  		redirect_to '/'
  	end
  end
   
  # GET /tag/:id
  def show
    puts params
    tag_slug = params[:id].parameterize
    @tag = Tag.find_by(tag_slug: tag_slug)
    @posts = @tag.posts
  end
end
