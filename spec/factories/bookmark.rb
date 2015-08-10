FactoryGirl.define do
   factory :bookmark do
     url "www.rubygems.org"
     topic
   end

   factory :bookmark_new, :class => 'bookmark' do
     url "www.google.com"
     topic
   end
 end
