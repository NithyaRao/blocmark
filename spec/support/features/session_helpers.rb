module Features
  module SessionHelpers
    def sign_up(name, email, password)
      visit new_user_registration_path
      fill_in 'user_name', with: name
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Sign up'
    end

    def sign_in(user)
      visit new_user_session_path
      # puts "NEW USER SESSION"
      # STDIN.getc
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      # puts "FILLED IN"
      # debugger
      click_button "Sign in"  
      # STDIN.getc
    end
   
    def create_bookmarks(url, topic_id)
      
      visit new_topic_bookmark_path(topic_id)
      fill_in 'bookmark_url', :with => url
      click_button "Save bookmark"
    end

    def delete_bookmarks(bookmark_id)
       debugger
       click_link("bkd-#{bookmark_id}")
    end

    def update_bookmarks(bookmark_id, url)
       click_link("bku-#{bookmark_id}")
       fill_in 'bookmark_url', :with => url
       click_button "Save bookmark"
    end
   
end

module WaitHelpers
   def wait(time, increment = 1, elapsed_time = 0, &block)
    begin
      yield
      rescue Exception => e
      if elapsed_time >= time
         raise e
      else
         sleep increment
         wait(time, increment, elapsed_time + increment, &block)
      end
  end
end
end
end