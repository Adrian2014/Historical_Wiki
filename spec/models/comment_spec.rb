require 'rails_helper'

describe Comment do

  describe "associations" do
    before do
      @comment = Comment.create
    end

    it 'should belong to post' do
      @comment.post = Post.create
      @comment.save
      expect(@comment.post).to be_a(Post)
      expect(@comment.post.comments.last.id).to eq(@comment.id)
    end

    it 'should belong to user' do
      @comment.user = User.create(DUMMY_USER_HASH)
      @comment.save
      expect(@comment.user).to be_a(User)
      expect(@comment.user.comments.last.id).to eq(@comment.id)
    end

    it 'should have many stars' do
      @comment.stars.create
      expect(@comment.stars.first).to be_a(Star)
      expect(@comment.stars.first.starable.id).to eq(@comment.id)
    end
  end
end