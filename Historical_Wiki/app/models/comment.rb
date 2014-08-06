# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
    belongs_to :post
    has_many :stars, as: :starable
end
