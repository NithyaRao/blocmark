require 'rails_helper'

RSpec.describe IncomingController, type: :controller do

  describe "POST #create" do
    let (:new_user_params) do { 'sender': 'someone@example.com',
                         'subject': 'List of Tech Companies', 
                         'body-plain': 'http://www.top-techcomp.com'
                           }  
                        end  
    let (:exist_user_params) do { 'sender': 'someone@example.com',
                         'subject': 'New Rails Gem', 
                         'body-plain': 'http://google.com/new_rails_gem'
                           }  
                        end  
    let (:exist_user_topic_params) do { 'sender': 'someone@example.com',
                         'subject': 'New Rails Gem', 
                         'body-plain': 'http://www.guides.rubygems.org'
                           }  
                        end                                                         
   describe "User does not exists" do 
     it "Creates User if user does not exists " do
      assert_difference('User.count') do 
         post :create,  new_user_params
      end
      assert_response :success
    end
      
    it "Creates Topic for the user if topic does not exists " do
      assert_difference('Topic.count') do 
         post :create,  new_user_params
      end
      assert_response :success
    end 
    it "For a valid user and topic, build and save a new bookmark" do
      assert_difference('Bookmark.count') do 
         post :create,  new_user_params
      end
      assert_response :success
    end
  end

  describe "User exists" do
    before do
         post :create, new_user_params
    end 
    it "Creates Topic for the user if topic does not exists " do
      assert_difference('Topic.count') do 
         post :create,  exist_user_params
      end
      assert_response :success
    end 
    it "For a valid user and topic, build and save a new bookmark" do
      assert_difference('Bookmark.count') do 
         post :create,   exist_user_params
      end
      assert_response :success
    end
  end 
 
  describe "User and Topic exists" do 
     before do
         post :create, exist_user_params 
      end 

     it "For a valid user and topic, build and save a new bookmark" do
         assert_difference('Bookmark.count') do 
         post :create,  exist_user_topic_params
      end
      assert_response :success
    end 
  end 
    
 end
end