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

  describe "on post show page" do
    before do
      @post = Post.create(post_title: "New title")
      visit post_path(@post)
    end

    it 'should allow the user to create a new comment' do
      expect(page).to have_link("", href:page.current_path + "/comments/new")
    end
  end

  context "on new comment page" do
    before do
      @user = User.create(DUMMY_USER_HASH)
      @post = Post.create(post_title: "Test post")
      visit new_post_comment_path(@post)
    end

    it 'can make a new comment for a post' do
      comment_text = "New comment"
      page.fill_in('comment_text', with: comment_text)
      page.click_button("Submit")

      comment = Comment.last

      expect(comment.comment_text).to eq(comment_text)
      expect(comment.post.id).to eq(@post.id)
    end
  end

  context "on new post page" do
    before do
      @user = User.create(DUMMY_USER_HASH)
      visit new_post_path
    end

    it 'can create a new post' do
      page.fill_in("post_title", with: "New title")
      page.fill_in("post_date", with: "2014-02-14")
      page.fill_in("post_text", with: "Text for New post")
      page.fill_in("tag_text", with: "tag one, tag two")
      page.click_button("Submit")

      expect(Post.last.post_title).to eq("New title")
    end

    it 'can create tags for that post' do
      page.fill_in("post_title", with: "New title")
      page.fill_in("post_date", with: "2014-02-14")
      page.fill_in("post_text", with: "Text for New post")
      page.fill_in("tag_text", with: "tag one, tag two")
      page.click_button("Submit")

      expect(Post.last.tags.count).to eq(2)
      expect(Post.last.tags.last.tag_text).to eq('tag two')
    end
  end

end
