class TopicsController < ApplicationController
  def index
     @topics = Topic.all
     authorize @topics
  end

  def show
     @topic = Topic.friendly.find(params[:id])
     @bookmarks = @topic.bookmarks
     @bookmark = Bookmark.new
     authorize @topic
     if request.path != topic_path(@topic)
       redirect_to @topic, status: :moved_permanently
     end 
  end

  def new
     @topic = Topic.new
     @user = current_user
     authorize @topic
  end

  def edit
     @topic = Topic.friendly.find(params[:id])
     authorize @topic
  end

   def create
     @user = current_user
     @topic = current_user.topics.build(topic_params)
     @topic.user = current_user
     authorize @topic
     if @topic.save
       redirect_to current_user, notice: "Topic was saved successfully."
     else
       flash[:error] = "Error creating topic. Please try again."
       render :new
     end
   end
 
   def update
     @topic = Topic.friendly.find(params[:id])
     authorize @topic
     if @topic.update_attributes(topic_params)
       redirect_to @topic
     else
       flash[:error] = "Error saving topic. Please try again."
       render :edit
     end
   end

   def destroy
     @topic = Topic.friendly.find(params[:id])
     authorize @topic
     if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
       redirect_to topics_path
     else
       flash[:error] = "There was an error deleting the Topic. Please try again."
       render :show
     end
  end

   private

  def topic_params
    params.require(:topic).permit(:title)
  end
end
