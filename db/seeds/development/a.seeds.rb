user = User.first
puts "#### Creating membership levels"
MembershipLevel.create!(name: 'Basic', allowed_messages: 10, allowed_contacts: 10)
MembershipLevel.create!(name: 'Premium', allowed_messages: nil)
MembershipLevel.create!(name: 'Sponsored', allowed_messages: nil)

puts "Default Membership level #{MembershipLevel.DEFAULT}"
puts "##### Development Seeding"
(1..8).each do |g|
  name = (0...5).map { (65 + rand(26)).chr }.join
  puts "##### Adding the #{name}"
  Group.create!(name: name , description: "Test #{g} ", user: user)
end


(1..8).each do |i|
  puts "##### Adding the Test#{i}@insomnia-consulting.org"
  Invite.create!(email: "Test#{i}@insomnia-consulting.org")
end

ActiveRecord::Base.transaction do
  puts "##### Adding a sponsor / advertisement"
  s = Sponsor.create(name: "NotifyMyClub", email: "info@notifymyclub.org", phone: "7244547790", active: true, messages_allowed: 10)
  a = Advertisement.new(message: "NotifyMyClub.com: Help your club get the word out.", html_message: "<b><a href=\"http://NotifyMyClub.com\">NotifyMyClub.com</a> Help your club get the word out.</b>", :phone_message => "Notify My Club dot com.  Help your club get the word out.")
  a.save
  s.advertisements << a
  s.save
end
ActiveRecord::Base.transaction do
  puts "##### Adding a sponsor / advertisement"
  s = Sponsor.create(name: "Insomnia Consulting", email: "gakins@insomnia-consulting.org", phone: "7244547790", active: true)
  a = Advertisement.new(message: "Insomnia-Consulting.org: Software development services.", html_message: "<b><a href=\"http://insomnia-consulting.org\">Insomnia-Consulting.org</a> Software development services.</b>", :phone_message => "Insomnia dash Consulting dot org.  Software development consulting.")
  a.save
  s.advertisements << a
  s.save
end
puts "##### Finished Development Seeding"


