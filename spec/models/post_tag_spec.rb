require 'rails_helper'

describe PostTag do

  describe "associations" do

    it 'should join Posts and Tags' do
      @post_tag = PostTag.new
      @post_tag.post = Post.create
      @post_tag.tag = Tag.create
      @post_tag.save
      expect(@post_tag.tag.posts.last).to be_a(Post)
      expect(@post_tag.post.tags.last).to be_a(Tag)
    end

  end
end