FactoryGirl.define do
   factory :item do
     sequence(:name, 100) { |n| "To-do Item#{n}" }
      user
   end
 end
 