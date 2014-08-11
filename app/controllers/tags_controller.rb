class TagsController < ApplicationController

  def search
  	@tag = Tag.find_by(tag_slug: params[:tag][:tag_text].parameterize)
  	if @tag != nil
      puts @tag
  		redirect_to @tag
  	else
  		redirect_to '/'
  	end
  end
   
  # GET /tags/:name
  def show
    puts params
    tag_slug = params[:id].parameterize
    @tag = Tag.find_by(tag_slug: tag_slug)
    @posts = @tag.posts
  end
end
