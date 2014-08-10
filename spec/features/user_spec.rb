require 'rails_helper'

feature 'Users who are not signed in' do

  context "on home page" do
    before do
      @post = Post.create(post_title: "Test post")
      visit posts_url
    end

    it 'can go to register page' do
      expect(page).to have_link('', href:users_new_path)
    end

    it 'can go to sign in page' do
      expect(page).to have_link('', href:'/users/login')
    end

    it 'can click on a post to go to the show page' do
      expect(page).to have_link(@post_title, @post)
    end

    it 'cannot edit posts' do
      expect(page).to have_no_link("", href:edit_post_path(@post))
    end

    it 'cannot delete posts' do
      expect(page).to have_no_css("a[data-method='delete'][href='#{post_path(@post)}']")
    end
  end

  context "on post show page" do
    before do
      @post = Post.create(post_title: "Test port")
      @tag = @post.tags.create(tag_text: "Example tag")
      @post.image = Image.create(image_url: "Example URL")
      @image = @post.image
      @comment = @post.comments.create(comment_text: "test comment")
      visit post_url(@post)
    end

    it 'shows post title and text' do
      expect(page).to have_content(@post.post_title)
      expect(page).to have_content(@post.post_text)
      expect(page).to have_content(@post.post_date)
    end

    it 'links to tags' do
      expect(page).to have_link('', href: tag_path(@tag))
    end

    it 'shows post comments' do
      expect(page).to have_content(@comment.comment_text)
    end

    it 'should not allow the user to make comments' do
      expect(page).to have_no_link("", href:page.current_path + "/comments/new")
    end
  end

  context "on log in page" do
    before do
      @user = User.create(DUMMY_USER_HASH)
      visit '/users/login'
    end

    it 'can log in' do
      expect(page).to have_css('form[action="/users/login"][method="post"]')
    end
  end

  context "on new comment page" do
    before do
      @user = User.create(DUMMY_USER_HASH)
      @post = Post.create(post_title: "Test post")
    end

    it 'can make a new post' do

    end
  end

end
