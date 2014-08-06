# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
    has_many :post_tags
    has_many :posts, through: :post_tags
end
