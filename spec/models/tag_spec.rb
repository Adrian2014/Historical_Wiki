# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  tag_text   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Tag do

  describe "associations" do

    it 'should have many posts' do
      tag = Tag.create
      tag.posts.create
      expect(tag.posts.last).to be_a(Post)
      expect(tag.posts.last.tags.last.id).to eq(tag.id)
    end

  end
end
