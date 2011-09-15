# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "This is a test"
user = User.find_by_email("angrygreg@gmail.com")
if user.nil?
  puts "Couldn't find the user"
end
user.approved = true
user.save
puts "finished with seeding"
