require 'rails_helper'

describe Star do

  describe "associations" do
    before do
      @star = Star.create
    end

    it 'should belong to a user' do
      @star.user = User.create(DUMMY_USER_HASH)
      @star.starable = Comment.create
      @star.save
      expect(@star.user).to be_a(User)
      expect(@star.user.stars.all.count).to eq(1)
    end

    it 'should be able to add a comment as a starable' do
      @star.starable = Comment.create
      @star.save
      expect(@star.starable).to be_a(Comment)
      expect(@star.starable.stars.count).to be(1)
    end

    it 'should be able to add a post as a starable' do
      @star.starable = Post.create
      @star.save
      expect(@star.starable).to be_a(Post)
      expect(@star.starable.stars.count).to be(1)
    end

    it 'should not be able to add any other models as a starable' do
      @star.starable = User.create(DUMMY_USER_HASH)
      expect(@star.save).to eq(false)
    end
  end
end