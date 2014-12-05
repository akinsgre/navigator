# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "##### Finding an admin user, or adding one."
user = User.create!(:email => "test0@insomnia-consulting.org", :password => "Password1")
admin = Admin.create!(:email => "admin@insomnia-consulting.org", :password => "Password1")
puts "##### Finished with seeding"



