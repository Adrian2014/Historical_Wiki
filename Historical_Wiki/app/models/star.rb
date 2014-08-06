# == Schema Information
#
# Table name: stars
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Star < ActiveRecord::Base
  belongs_to :starable, polymorphic: true
end
