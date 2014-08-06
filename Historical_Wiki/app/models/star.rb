# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :starable, polymorphic: true

  validates :starable_type, inclusion: {in: %w(Comment Post), message: "%(value) is not a valid starable class"}
end
