class CommentsController < ApplicationController
  before_filter :require_signed_in!
  
  def create
    thing_id = params[:comment][:thing_id]
    this_comment_params = comment_params.merge(user_id: current_user.id) 
    @thing = Thing.find(thing_id)
    @comment = @thing.comments.build(this_comment_params)
#    @commeasdnt[:user_id] = current_user
    
    if @comment.save
      flash[:notice] = "Comment created!"
      redirect_to @thing
    else
      flash[:alert] = "You can't post a blank comment."
      redirect_to @thing
    end
  end


  private
  
  def comment_params
    params.require(:comment).permit(:thing_id, :description, :content, :user_id)
  end

end
