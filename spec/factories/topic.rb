FactoryGirl.define do
   factory :topic do
     sequence(:title, 100) { |n| "Topic title#{n}" }
     user
   end
 end