require 'rails_helper'
 
 describe User do
 
 describe "#liked(bookmark)" do
      let!(:user) { create( :user) }
      let!(:topic) { create( :topic, user: user) }
      let!(:bookmark) { create( :bookmark, topic: topic, user: user) }

     it "returns `nil` if the user has not favorited the post" do
        debugger
        expect(user.likes.find_by_bookmark_id(bookmark.to_param)).to be_nil    
     end
 
     it "returns the appropriate favorite if it exists" do
        like = user.likes.where(bookmark: bookmark).create
         expect(user.likes.find_by_bookmark_id(bookmark.to_param)).to eq(like)
     end
   end
 end