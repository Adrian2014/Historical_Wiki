require 'rails_helper'

feature 'Users who are not signed in' do

  context "on home page" do
    before do
      @post = Post.create(post_title: "Test post")
      visit posts_url
    end

    it 'can register' do
      click_link("Register")
      expect(page).to have_content("Register!")
    end

    it 'can click on a post to go to the show page' do
      expect(page).to have_link(@post_title, @post)
    end

    it 'cannot edit posts' do
      expect(page).to have_no_link("Edit", edit_post_url(@post))
    end

    it 'cannot delete posts' do
      expect(page).to have_no_link("Destroy", post_url(@post))
    end
  end

  context "on post show page" do

    before do
      @post = Post.create(post_title: "Test port")
      visit post_url(@post)
    end

    it 'shows post title and text' do
      expect(page).to have_content(@post.post_title)
      expect(page).to have_content(@post.post_text)
      expect(page).to have_content(@post.post_date)
    end

  end

end