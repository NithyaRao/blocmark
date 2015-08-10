class UsersController < ApplicationController
  def show
     @user = User.find(params[:id])
     @topics = Topic.all
    # @bookmarks = @topics.bookmarks.all
     @topic = Topic.new
     @bookmark = Bookmark.new
  end

end