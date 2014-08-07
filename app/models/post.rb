# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
    def self.between_years(start_year, end_year)
      start_date = "#{start_year}-01-01"
      end_date = "#{end_year-1}-12-31"
      Post.where(post_date: start_date..end_date).order(:post_date)
    end

    def self.get_data(start_year, end_year, precision)
      posts = Post.between_years(start_year, end_year).to_a
      data = Hash.new
      block = start_year/precision

      posts.each do |post|
        while post.year >= (block+1)*precision
          block += 1
        end
        data[block] = [] unless data[block]
        data[block].push post
      end

      return data
    end

    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :comments
    has_one :image

    has_many :stars, as: :starable

    def date
      @date ||= Date.parse(self.post_date)
    end

    def year
      self.date.year
    end
end
