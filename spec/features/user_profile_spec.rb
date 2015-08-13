require 'rails_helper'
 describe "User Profile ", type: :feature, js: true do 
     let(:user) { create( :user) }
     let!(:new_user) { create(:user, name: "John Doe")}
     let!(:topic) { create(:topic, user: user) }
     let!(:bookmark_1) { create( :bookmark, topic: topic, user: user) }
     let!(:bookmark_3) { create( :bookmark, topic: topic, user: user)}
     let!(:bookmark_2) { create(:bookmark, topic: topic, user: new_user)  }
     let!(:bookmark_4) { create(:bookmark, user: new_user)  }
     # user liked new_user's bookmark
     let!(:liked_1) { create(:like, bookmark: bookmark_2, user: user)}
     # new_user liked user's bookmark 
     let!(:liked_2) { create(:like, bookmark: bookmark_3, user: new_user) }
     # user liked user's bookmark
     let!(:liked_3) { create(:like, bookmark: bookmark_3, user: user) }


    before {  sign_in(user)  }

    describe "display bookmarks" do
     it "displays all a user has created or liked in their profile?" do
        display_user_profile

         wait 1 do 
           expect( current_path ).to eq myblocmarks_path
         end
         wait 1 do
           expect(page).to have_link("top-#{topic.to_param}")
           expect(page).not_to have_link("bku-#{bookmark_2.to_param}")
           expect(page).not_to have_link("top-#{bookmark_4.to_param}") 
           #with js: true it cannot find link with id so use embedly 
           expect(page).to have_css('div.embedly-card', count: 3)
           expect(page).to have_selector('iframe', count: 3)
        end 
     end
    end
    describe "Is user able to unlike a liked bookmark from their profile page?" do
     it "user able to unlike a liked bookmark that user created " do
           expect(user.likes.count).to eq(2)
           unlike_bookmarks(bookmark_3.to_param) 
           wait 1 do 
           expect(user.likes.count).to eq(1)
           # As this bookmark belongs to user expect to see in the user profile
           expect(page).to have_link("lk-#{bookmark_3.to_param}")
           end
     end
     it "user able to unlike a liked bookmark that other user created " do
           expect(user.likes.count).to eq(2)
           unlike_bookmarks(bookmark_2.to_param) 
           wait 1 do 
           expect(user.likes.count).to eq(1)
           # As this bookmark belongs to other user expect not to see in the user profile
           expect(page).not_to have_link("lk-#{bookmark_2.to_param}")
           end
     end
   end
end
