class BookmarksController < ApplicationController
  
  def show
     #debugger
     @user = current_user
     @topic = Topic.find(params[:id])
     @bookmarks = @topic.bookmarks
     @bookmark = Bookmark.new
     authorize @bookmark
  end

  def new
     @topic = Topic.find(params[:topic_id])
     @user = current_user
     @bookmark = Bookmark.new
     @bookmark.topic = @topic
     @bookmark.user = @user
     authorize @bookmark
  end

 def create
     @topic = Topic.find(params[:topic_id])
     @user = current_user
     @bookmark = @topic.bookmarks.build(bookmark_params)
     @bookmark.topic = @topic
     @bookmark.user = @user
     authorize @bookmark
     if @bookmark.save
       flash[:notice] = "Bookmark was saved."
       redirect_to [@topic]
     else
       flash[:error] = "There was an error saving the bookmark. Please try again."
       render :new
     end
   end

 def edit
     @topic = Topic.find(params[:topic_id])
     @bookmark = Bookmark.find(params[:id])
     authorize @bookmark
  end

def update
      @topic = Topic.find(params[:topic_id])
      @user = current_user
      @bookmark = Bookmark.find(params[:id])
      authorize @bookmark
    if @bookmark.update_attributes(bookmark_params)

       flash[:notice] = "bookmark was updated."
       redirect_to [@topic]
     else
       flash[:error] = "There was an error saving the bookmark. Please try again."
       render :edit
     end
  end

def destroy
     @bookmark = Bookmark.find(params[:id])
     @topic = @bookmark.topic
     authorize @bookmark
     if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
       redirect_to [@topic]
     else
       flash[:error] = "There was an error deleting the Topic. Please try again."
       render 'topics/show'
     end
  end
private

def bookmark_params
  params.require(:bookmark).permit(:url)
end

end

