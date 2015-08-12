FactoryGirl.define do
   factory :bookmark do
     url "www.rubygems.org"
     topic
     user
   end

   factory :bookmark_new, :class => 'bookmark' do
     url "www.google.com"
     topic
     user
   end
   
    
 end
