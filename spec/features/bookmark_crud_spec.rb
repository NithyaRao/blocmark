require 'rails_helper'

describe "Topic Bookmark CRUD", type: :feature, js: true do
    let(:user) { create( :user) }
    let!(:new_user) { create(:user, name: "John Doe")}
    let!(:topic) { create( :topic, user: user) }
    let!(:bookmark) { create( :bookmark, topic: topic, user: user) }
    let!(:bookmark_new) { build( :bookmark_new, topic: topic, user: user)}

    before {  sign_in(user)  }

 describe "bookmark CREATE: "  do 
  describe "If bookmark exists" do
    it "displays bookmark" do
        wait 1 do 
          expect( current_path ).to eq topics_path
        end
        expect(page).to have_css('div.embedly-card', count: 1)
        expect(page).to have_selector('iframe', count: 1)
    end
  end   

  describe "if bookmark does not exist" do    
    it "creates the bookmark adds to the Topic" do
      #debugger
       wait 1 do
         expect( current_path ).to eq topics_path
       end 
      create_bookmarks( bookmark_new.url, topic.to_param)
      
       wait 1 do
         # because 1 bookmark already exists by  let!(:bookmark) { create(:bookmark, topic: topic) } so expect 2 bookmarks.
         expect( topic.bookmarks.count).to eq(2)
       end
    end 

   it "Are the Topic bookmarks displayed after creation? " do
      wait 1 do
         expect( current_path ).to eq topics_path
      end
      create_bookmarks( bookmark_new.url, topic.to_param)
      wait 1 do 
        expect(page).to have_css('div.embedly-card', count: 2)
        expect(page).to have_selector('iframe', count: 2)
      end       
   end
  end
 end 
 describe "Bookmark DELETE: " do
   describe "Are you able to delete" do
       it "can you delete your bookmark? " do
         wait 1 do
           expect( current_path ).to eq topics_path 
         end  
         delete_bookmarks(bookmark.to_param)
         wait 1 do 
           expect(topic.bookmarks.count).to eq(0) 
         end   
      end   
      it "can you delete other users bookmark ? " do
         bookmark_other = create(:bookmark, user: new_user)
         wait 1 do
           expect( current_path ).to eq topics_path 
         end  
        # delete_bookmarks(bookmark.to_param)
          expect(page).not_to have_link("bkd-#{bookmark_other.to_param}")
         wait 1 do 
           expect(topic.bookmarks.count).to eq(1) 
         end   
      end   
   end
 end 

 describe "Bookmark UPDATE: " do
   describe "Are you able to update" do
       it "can you update your bookmark url? " do
         wait 1 do
           expect( current_path ).to eq topics_path 
         end  
         update_bookmarks(bookmark.to_param, bookmark_new.url)
         wait 1 do 
         expect(Bookmark.find(bookmark.to_param).url).to eq(bookmark_new.url)
         expect(page).to have_css('div.embedly-card', count: 1)
         expect(page).to have_selector('iframe', count: 1)
         end     
      end  
      it "can you update other users bookmark url ? " do
          bookmark_other = create(:bookmark, user: new_user)
         wait 1 do
           expect( current_path ).to eq topics_path 
         end  
       #  update_bookmarks(bookmark.to_param, bookmark_new.url)
         wait 1 do 
         expect(page).not_to have_link("bku-#{bookmark_other.to_param}")
          expect(topic.bookmarks.count).to eq(1) 
         end     
      end    
   end
 end 
end