user = User.first

puts "##### Development Seeding"
puts "#### Creating membership levels"
MembershipLevel.create!(name: 'Basic', allowed_messages: 10, allowed_contacts: 10)
MembershipLevel.create!(name: 'Premium', allowed_messages: nil)
MembershipLevel.create!(name: 'Sponsored', allowed_messages: nil)

puts "Default Membership level #{MembershipLevel.DEFAULT.inspect}"

(1..8).each do |g|
  name = (0...5).map { (65 + rand(26)).chr }.join
  puts "##### Adding the #{name}"
  Group.create!(name: name , description: "Test #{g} ", users: [user])
end

(1..8).each do |i|
  puts "##### Adding the Test#{i}@insomnia-consulting.org"
  Invite.create!(email: "Test#{i}@insomnia-consulting.org")
end

ActiveRecord::Base.transaction do
  puts "##### Adding a sponsor / advertisement"
  s = Sponsor.create(name: "NotifyMyClub", email: "info@notifymyclub.org", phone: "7244547790")
  s.save
end
puts "##### Finished Development Seeding"


