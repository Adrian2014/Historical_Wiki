# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Image < ActiveRecord::Base
    belongs_to :post
end
