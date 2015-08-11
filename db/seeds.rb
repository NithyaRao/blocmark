require 'faker'
 
  # Create Users
 10.times do
   user = User.new(
     name:     Faker::Name.name,
     email:    Faker::Internet.email,
     password: Faker::Lorem.characters(10)
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all
 
 # Note: by calling `User.new` instead of `create`,
 # we create an instance of User which isn't immediately saved to the database.
 
 # The `skip_confirmation!` method sets the `confirmed_at` attribute
 # to avoid triggering an confirmation email when the User is saved.
 
 # The `save` method then saves this User to the database. 
 
 10.times do
   Topic.create!(
     user:   users.sample,
     title:   Faker::Lorem.sentence,
   )
 end
 topics = Topic.all

 10.times do
   Bookmark.create!(
     user:   users.sample,
     topic:  topics.sample,
     url:   Faker::Internet.url,
   )
 end


 puts "Seed finished"
 puts "#{User.count} Users created"
 puts "#{Topic.count} Topics created"
 puts "#{Bookmark.count} Bookmarks created"
 