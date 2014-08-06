require 'rails_helper'

describe Post do

  describe "associations" do
    before do
      @post = Post.create
    end

    it 'should have many tags' do
      @post.tags.create
      expect(@post.tags.first).to be_a(Tag)
      expect(@post.tags.first.posts.last.id).to eq(@post.id)
    end

    it 'should have many comments' do
      @post.comments.create
      expect(@post.comments.first).to be_a(Comment)
      expect(@post.comments.first.post.id).to eq(@post.id)
    end

    it 'should have one image' do
      @post.image = Image.create
      expect(@post.image).to be_a(Image)
      expect(@post.image.post.id).to eq(@post.id)
    end

    it 'should belong to user' do
      @post.user = User.create(DUMMY_USER_HASH)
      @post.save
      expect(@post.user).to be_a(User)
      expect(@post.user.posts.last.id).to eq(@post.id)
    end
  end
end