# == Schema Information
#
# Table name: post_tags
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class PostTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post
end
