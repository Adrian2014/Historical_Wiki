# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  post_id      :integer
#  user_id      :integer
#  comment_text :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Comment < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    has_many :stars, as: :starable
end
