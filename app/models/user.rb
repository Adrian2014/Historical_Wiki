# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin_id        :integer
#  email           :string(255)
#  username        :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :stars

  validates :email, presence: true, uniqueness: true


end
