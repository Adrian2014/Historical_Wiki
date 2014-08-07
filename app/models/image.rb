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

class Image < ActiveRecord::Base
    belongs_to :post
end
