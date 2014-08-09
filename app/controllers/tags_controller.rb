class TagsController < ApplicationController

  # GET /tag/:id
  def show
    puts params
    tag_slug = params[:id].parameterize
    @tag = Tag.find_by(tag_slug: tag_slug)
    @posts = @tag.posts
  end
end
