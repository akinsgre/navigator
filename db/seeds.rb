# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "##### Finding an admin user, or adding one."
user = User.find_by_email("admin@insomnia-consulting.org")
if user.nil?
  puts "##### Couldn't find the user.. creating one"

  user = User.create!(:email => "admin@insomnia-consulting.org", :password => "password1")
end

puts "Trying to assign Administrator Role to User"

role = Role.find_by_name("Administrator")
if role.nil?
  role = Role.create!({:name => "Administrator"})
end

user.role.push(role)
puts "##### #{user.email} is now an Administrator"
user.save
(1..8).each do |g|
  name = (0...5).map { (65 + rand(26)).chr }.join
  puts "##### Adding the #{name}"
  Group.create!(name: name , description: "Test #{g} ", user: user)
end

ActiveRecord::Base.transaction do
puts "##### Adding a sponsor / advertisement"
s = Sponsor.create(name: "NotifyMyClub", email: "info@notifymyclub.org", phone: "7244547790")
a = Advertisement.new(message: "NotifyMyClub.org: Help your club get the word out.", html_message: "<b><a href=\"http://NotifyMyClub.org\">NotifyMyClub.org</a>Help your club get the word out.</b>")
a.save
s.advertisements << a
s.save
end

puts "##### Finished with seeding"



