class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
   before_action :configure_permitted_parameters, if: :devise_controller?
   
  rescue_from Pundit::NotAuthorizedError do |exception|
     redirect_to root_url, alert: exception.message
   end


   protected
 
   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :name
   end

   # Added this to prevent browser caching as the back button didnot refesh the page .
 #  before_filter :set_cache_buster

 # def set_cache_buster
  #  response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  #  response.headers["Pragma"] = "no-cache"
  #  response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
#  end
end
