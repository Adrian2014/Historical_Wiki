# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Post.delete_all
Comment.delete_all
Tag.delete_all
Star.delete_all
Image.delete_all

10.times do
  User.create( email: Faker::Internet.email,
               username: Faker::Internet.user_name,
               password: "temp1234",
               password_confirmation: "temp1234",
               )

end

10.times do
  Post.create( user_id: User.all.sample.id,
               post_title: Faker::Name.title,
               post_text: Faker::Lorem.paragraph(4),
               post_date: Date.today-rand(10000)
               )
end

10.times do
  Comment.create( post_id: Post.all.sample.id,
                  user_id: User.all.sample.id,
                  comment_text: Faker::Lorem.paragraph(2)
                  )
end

10.times do
  Tag.create( tag_text: Faker::Hacker.noun)
end

10.times do
  PostTag.create(post_id:User.all.sample.id,
                 tag_id:Tag.all.sample.id)

end

10.times do
  Star.create( user_id: User.all.sample.id,
               ratings: rand(6),
               starable_id: [Comment.all.sample.id, Post.all.sample.id].sample,
               starable_type: [Post.to_s, Comment.to_s].sample
               )

end
