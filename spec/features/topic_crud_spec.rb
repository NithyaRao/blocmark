require 'rails_helper'

describe "Bookmarks displayed for each Topic", type: :feature, js: true do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let!(:bookmark) { create(:bookmark,topic: topic) }
    let!(:bookmark_new) { create(:bookmark_new, topic: topic) }
  
    before { sign_in(user) }
    
    it "displays bookmarks for topic" do
        wait 1 do 
          expect( current_path ).to eq user_path(topic.to_param)
        end
        save_and_open_page
       # debugger
        expect(page).to have_css('div.embedly-card', count: 2)
       # save_and_open_page
       # debugger
        expect(page).to have_selector('iframe', count: 2)
    end
end   