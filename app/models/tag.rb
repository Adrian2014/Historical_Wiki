# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  tag_text   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags

  before_validation :build_slug

  validates :tag_slug, uniqueness: true

  def build_slug
    self.tag_slug = self.tag_text.parameterize
  end
end
