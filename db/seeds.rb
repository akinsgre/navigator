# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "Finding an admin user, or adding one."
user = User.find_by_email("admin@insomnia-consulting.org")
if user.nil?
  puts "Couldn't find the user.. creating one"

  user = User.create!(:email => "admin@insomnia-consulting.org", :password => "password1")
end

puts "Trying to assign Administrator Role to User"

role = Role.find_by_name("Administrator")
if role.nil?
  role = Role.create!({:name => "Administrator"})
end

user.role.push(role)
puts "#{user.email} is now an Administrator"
user.save

puts "Adding ContactType Types if they don't exist"

unless ContactType.exists?(1)
  ContactType.create!({:id => 1, :name => "Email"})
end

unless ContactType.exists?(2)
  ContactType.create!({:id => 2, :name => "Phone"})
end
unless ContactType.exists?(3)
  ContactType.create!({:id => 3, :name => "SMS"})
end


puts "finished with seeding"



