# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_title :string(255)
#  post_text  :text
#  post_date  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
    def self.between_years(start_year, end_year)
      start_date = "#{start_year}-01-01"
      end_date = "#{end_year-1}-12-31"
      Post.where(post_date: start_date..end_date).order(:post_date)
    end

    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :comments
    has_one :image

    has_many :stars, as: :starable

    def year
      if self.post_date
        self.post_date.year
      else
        0
      end
    end
end
