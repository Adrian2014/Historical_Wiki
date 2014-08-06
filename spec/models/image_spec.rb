require 'rails_helper'

describe Image do

  describe "associations" do
    before do
      @image = Image.create
    end

    it 'should belong to a post' do
      @image.post = Post.create
      @image.save
      expect(@image.post).to be_a(Post)
      expect(@image.post.image.id).to eq(@image.id)
    end
  end
end