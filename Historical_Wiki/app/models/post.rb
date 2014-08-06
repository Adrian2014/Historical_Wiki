# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :comments
    has_one :image
end
