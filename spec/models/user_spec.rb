require 'rails_helper'

describe User do

  describe 'associations' do

    before do
      @user = User.create(DUMMY_USER_HASH)
    end

    it 'should have many posts' do
      @user.posts.create
      expect(@user.posts.last).to be_a(Post)
      expect(@user.posts.last.user.id).to eq(@user.id)
    end

    it 'should have many comments' do
      @user.comments.create
      expect(@user.comments.last).to be_a(Comment)
      expect(@user.comments.last.user.id).to eq(@user.id)
    end

    it 'should have many stars' do
      @user.stars.create
      expect(@user.stars.last).to be_a(Star)
      expect(@user.stars.last.user.id).to eq(@user.id)
    end

  end

end