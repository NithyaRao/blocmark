class BookmarksController < ApplicationController
  def index
     @bookmarks = Bookmark.all
     authorize @bookmarks
  end

  def show
     @bookmark = Bookmark.find(params[:id])
     authorize @bookmark
   end
   
  def new
     @topic = Topic.find(params[:topic_id])
     @bookmark = Bookmark.new
     @bookmark.topic = @topic
     authorize @bookmark
  end

end