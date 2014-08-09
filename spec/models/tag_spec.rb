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
      tag = Tag.create(tag_text:"Example Tag")
      tag.posts.create
      expect(tag.posts.last).to be_a(Post)
      expect(tag.posts.last.tags.last.id).to eq(tag.id)
    end

  end

  describe "#initialize" do
    it 'should create a slug upon creation' do
      tag = Tag.create(tag_text:"Example Tag")
      expect(tag.tag_slug).to eq("example-tag")
    end

    it 'should not create two tags with the same slug' do
      tag = Tag.create(tag_text:"Example Tag")
      tag2 = Tag.new(tag_text:"example tag")
      expect(tag2.save).to eq(false)
    end
  end
end
