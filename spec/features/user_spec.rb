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
      @image = @post.image.create(image_url: "Example URL")
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
  end

  context "on log in page" do
    before do
      @user = User.create(DUMMY_USER_HASH)
      visit '/users/login'
    end

    it 'logs in when a correct email and password are used' do
      page.fill_in 'Email', with: DUMMY_USER_HASH[:email]
      page.fill_in 'Password', with: DUMMY_USER_HASH[:password]
      page.click_button 'Sign In!'

      expect(page.get_rack_session['id']).to eq(@user.id)
    end

    it 'does not log in when an incorrect username or password is used' do
      page.fill_in 'Email', with: DUMMY_USER_HASH[:email]
      page.fill_in 'Password', with: "Invalid password"
      page.click_button 'Sign In!'

      expect(page.get_rack_session['id']).to eq(nil)
    end
  end

end
