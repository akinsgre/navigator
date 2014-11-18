ActiveRecord::Base.transaction do
  puts "##### Adding a sponsor / advertisement"
  s = Sponsor.create(name: "NotifyMyClub", email: "info@notifymyclub.org", phone: "7244547790")
  a = Advertisement.new(message: "NotifyMyClub.org: Help your club get the word out.", html_message: "<b><a href=\"http://NotifyMyClub.org\">NotifyMyClub.org</a> Help your club get the word out.</b>", :phone_message => "Notify My Club dot org.  Help your club get the word out.")
  a.save
  s.advertisements << a
  s.save
end
puts "##### Finished Development Seeding"
