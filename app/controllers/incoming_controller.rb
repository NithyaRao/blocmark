class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    #debugger
    logger.debug "INCOMING PARAMS HERE: #{params}"

    # Find the user by using params[:sender]
     sender_email = params[:sender]
    # Find the topic by using params[:subject]
     sender_topic = params[:subject]
     # Assign the url to a variable after retreiving it from params["body-plain"]
     bookmark_url = params["body-plain"]

     # Check if user is nil, if so, create and save a new user
     if ( @user = User.find_by(email: sender_email)).nil? 
        @user = User.new(name: 'name' , email: sender_email, password: "helloworld", password_confirmation: "helloworld") 
        @user.skip_confirmation!
        @user.save!        
     end

     # Check if the topic is nil, if so, create and save a new topic
     if (@user) && (@topic = @user.topics.find_by(title: sender_topic )).nil?
        @topic = @user.topics.create(title: sender_topic)
        @topic.save!
     end
     
     if @user && @topic  
     # Now that you're sure you have a valid user and topic, build and save a new bookmark
     @bookmark = @topic.bookmarks.create(url: bookmark_url)
     @bookmark.save!
     end

    # Assuming all went well. 
    head 200
  end
end