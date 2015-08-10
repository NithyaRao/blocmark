require 'rails_helper'

RSpec.describe TopicsController, type: :controller, js: true do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:topic) { FactoryGirl.create(:topic, user: user) } 
      let!(:bookmark) { FactoryGirl.create(:bookmark, topic: topic) } 

    before  do
      #@request.env["devise.mapping"] = Devise.mappings[:user]
     #  sign_in user
     # allow(request.env['warden']).to receive(:authenticate!) { user }
       fake_sign_in(user)
      # allow(controller).to receive(:current_user) { user }
      end 

  describe "POST #create" do
     
    it "Creates Topic if topic does not exists " do
      assert_difference('Topic.count') do 
         post :create, topic: attributes_for(:topic)
      end
      assert_response :redirect, @response.body

    end
  end
  describe "DELETE destroy" do
    it "Deletes Topic and all its bookmark urls" do
      #  debugger
        assert_difference('Topic.count', -1) do 
         delete :destroy, {id: topic.to_param}
      end
      assert_equal(Bookmark.count, 0 )
      assert_response :redirect, @response.body
 
     
    end
  end

end