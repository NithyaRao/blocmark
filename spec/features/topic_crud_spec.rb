require 'rails_helper'

describe "Bookmarks displayed for each Topic", type: :feature, js: true do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let!(:bookmark) { create(:bookmark,topic: topic) }
    let!(:bookmark_new) { create(:bookmark_new, topic: topic) }
  
    before {  sign_in(user)  }
    
   describe "Within all Topics " do 
    it "displays bookmarks by topic" do
        wait 1 do 
          expect( current_path ).to eq topics_path
        end
       # save_and_open_page
       # debugger
         expect(page).to have_link("top-#{bookmark.to_param}")
         expect(page).to have_css('div.embedly-card', count: 2)
         expect(page).to have_selector('iframe', count: 2)

    end
  end
   describe "Within a Topic" do
    it "displays only bookmarks belonging to the topic " do
        topic_other = create(:topic, user: user )
        bookmark_other = create(:bookmark, topic: topic_other)
        display_topic(topic.to_param)
        wait 1 do 
          expect( current_path ).to eq topic_path(topic.to_param)
        end
        expect(page).to have_css('div.embedly-card', count: 2)
        expect(page).to have_selector('iframe', count: 2)
        expect(page).to have_link("top-#{bookmark.to_param}")
        expect(page).not_to have_link("top-#{bookmark_other.to_param}")   
    end 
  end 

end   