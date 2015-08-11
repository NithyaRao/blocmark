class LikesController < ApplicationController
   def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     @like = current_user.likes.build(bookmark: @bookmark)
 
     if @like.save
       # Add code to generate a success flash and redirect to @bookmark
       redirect_to current_user, notice: "Bookmark liked"
     else
       # Add code to generate a failure flash and redirect to @bookmark
       flash[:error] = "Error Bookmark like. Please try again."
       redirect_to current_user
     end
   end

   def destroy
     # Get the bookmark from the params
      @bookmark = Bookmark.find(params[:bookmark_id])
     # Find the current user's like with the ID in the params
      @like = Like.find(params[:id])
     if @like.destroy
      redirect_to current_user, notice: "Bookmark Unliked"
       # Flash success and redirect to @bookmark
     else
       # Flash error and redirect to @bookmark
      #  flash[:error] = "Error Bookmark like. Please try again."
       redirect_to current_user, error: "Error Unliking Bookmark. Please try again"
     end
   end
end
