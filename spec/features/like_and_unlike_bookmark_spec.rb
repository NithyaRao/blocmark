require 'rails_helper'

describe "Topic Bookmark CRUD", type: :feature, js: true do
    let(:user) { create( :user) }
    let!(:new_user) { create(:user, name: "John Doe")}
    let!(:bookmark) { create( :bookmark, user: user) }
   
    before {  sign_in(user)  }
     describe "Are you able to like bookmarks created by other users?" do
       it " Like others bookmark" do
           bookmark_other = create(:bookmark, user: new_user)
           like_bookmarks(bookmark_other.to_param) 
          # save_and_open_page
          # debugger
           wait 1 do 
           expect(user.likes.count).to eq(1)
           expect(page).to have_link("unlk-#{bookmark_other.to_param}")
           end
      end 
     end
     describe "Are you able to like bookmarks created by you?" do
      it "Like your bookmark" do
          like_bookmarks(bookmark.to_param) 
           wait 1 do 
           expect(user.likes.count).to eq(1)
           expect(page).to have_link("unlk-#{bookmark.to_param}")
           end
      end
    end
     describe "Are you able to unlike a previously liked bookmarks?" do
       before {
          like_bookmarks(bookmark.to_param) 
       }
      it "Unlike a previously liked bookmark" do
           unlike_bookmarks(bookmark.to_param) 
           wait 1 do 
           expect(user.likes.count).to eq(0)
           expect(page).to have_link("lk-#{bookmark.to_param}")
           end
      end
     end
end