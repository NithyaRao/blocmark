require 'rails_helper'
 
 describe User do
      let!(:user) { create( :user) }
      let!(:topic) { create( :topic, user: user) }
      let!(:bookmark_1) { create( :bookmark, topic: topic, user: user) }
      let!(:bookmark_2) { create( :bookmark, topic: topic, user: user) }
  
 
 describe "#liked(bookmark)" do

     it "returns `nil` if the user has not liked anybookmark" do
        #debugger
        expect(user.likes.find_by_bookmark_id(bookmark_1.to_param)).to be_nil    
     end
 
     it "returns the liked bookmark if it exists" do
        like = user.likes.where(bookmark: bookmark_1).create
         expect(user.likes.find_by_bookmark_id(bookmark_1.to_param)).to eq(like)
     end
   end

  describe "#created_bookmarks" do
    it "returns all bookmarks created by the user" do
       bookmarks = user.bookmarks.includes( :topic )
      expect(bookmarks.count).to eq(2)
    end
 end

 describe "#liked_bookmarks" do
    it "returns all bookmarks created by the user" do
       like = create(:like, bookmark: bookmark_1, user: user)

       bookmarks = user.likes.includes( bookmark: :topic ).map(&:bookmark)
      expect(bookmarks.count).to eq(1)
    end
 end
end 