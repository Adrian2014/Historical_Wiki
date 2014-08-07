# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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
