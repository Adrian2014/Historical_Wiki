require 'rails_helper'

feature 'users who are signed in' do
  before do
    @user = User.create(DUMMY_USER_HASH)
    visit '/users/login'
    page.fill_in 'Email', with: DUMMY_USER_HASH[:email]
    page.fill_in 'Password', with: DUMMY_USER_HASH[:password]
    page.click_button 'Sign In!'
  end

  describe 'on home page' do
    before do
      visit '/'
    end

    it 'should be able to access their posts' do
      expect(page).to have_link('', href:'/users/show')
    end

    it 'should be able to log out' do
      expect(page).to have_link('', href:'/users/logout')
    end
  end

  describe "on user's posts page" do
    before do
      @post = @user.posts.create(post_title: "New title")
      visit '/users/show'
    end

    it 'should be able to create a new post' do
      expect(page).to have_link('', href:new_post_path)
    end

    it 'should be able to edit an existing post' do
      expect(page).to have_link('', href:edit_post_path(@post))
    end

    it "should be able to see the user's own posts" do
      expect(page).to have_link('', href:post_path(@post))
    end

    it 'should be able to destroy an existing post' do
      expect(page).to have_css("a[data-method='delete'][href='#{post_path(@post)}']")
    end
  end
end
