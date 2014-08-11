# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'nokogiri'

User.delete_all
Post.delete_all



User.create( email: "admin@hiki.com",
             username: "Admin",
             password: "hiki1234567890",
             password_confirmation: "hiki1234567890",
             )


# Post.create( user_id: User.first.id,
#              post_title: Faker::Name.title,
#              post_text: Faker::Lorem.paragraph(4),
#              post_date: Date.today-rand(10000)
#              )


url = "http://simple.wikipedia.org/wiki/Attack_on_Pearl_Harbor"
agent = Mechanize.new
page = agent.get(url)

pages_to_scrub = page.links

pages_to_scrub.each do |link|
  begin
    temp = agent.get(link)
    if temp.code.match('200')
      temp = link.click
      url = temp.uri.to_s
      page = Nokogiri::HTML(open(url))
      page_text = page.css("div.mw-content-ltr > p:first").text()
      page_text.gsub!(/(\[.])/, "")
      temp_date = page.css("table td:nth-child(2)")[0]
      if temp_date != nil
        date = page.css("table td:nth-child(2)")[0].text()
        d = date.match(/\d{4}/)
        d = d.to_s
        d.insert(0,"1 January ")
        # new_date = Chronic.parse(d)
        nd = Date.parse(d)
      end
    end

    Post.create(
      user_id: User.first.id,
      post_title: page.css("#firstHeading").inner_text(),
      post_text: page_text,
      post_date: nd
    )
  rescue Mechanize::ResponseCodeError => e
    puts e.to_s
    next
  end
end
