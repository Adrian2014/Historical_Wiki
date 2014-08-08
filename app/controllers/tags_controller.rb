class TagsController < ApplicationController

  # GET /tag/new
  def show
    tag_name = params[:tag_name]
    @tags = Tag.where(tag_text: tag_name)
  end
end
