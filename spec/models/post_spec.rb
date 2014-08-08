# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_title :string(255)
#  post_text  :text
#  post_date  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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

  describe '.between_years' do
    before do
      Post.create(post_date: "500-01-01")
      Post.create(post_date: "1000-01-01")
      Post.create(post_date: "1500-01-01")
    end

    it 'should return all posts found between two years' do
      expect(Post.between_years(800, 1200).count).to eq(1)
      expect(Post.between_years(800, 1700).count).to eq(2)
    end

    it 'should include the starting year, but not the ending year' do
      expect(Post.between_years(500, 1000).count).to eq(1)
    end
  end

  describe '#year' do
    it 'should return the year of a post' do
      @post = Post.create(post_date: "1434-12-05")
      expect(@post.year).to eq(1434)
    end
  end
end
