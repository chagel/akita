#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.first
(1..30).each do |i|
	user.links.create!(:title => '标题123彼岸天时地利开发', url: 'http://baidu.com/test/newlink', description: "sdkfsldjkf", user: user)
end