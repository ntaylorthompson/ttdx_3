class CommentsController < ApplicationController
  before_filter :require_signed_in!
  
  def create
    thing_id = params[:comment][:thing_id]
    @thing = Thing.find(thing_id)
    @comment = @thing.comments.build(comment_params)
    @comment[:user_id] = @thing.user_id
    
    if @comment.save
      flash[:notice] = "Comment created!"
      redirect_to @thing
    else
      flash[:alert] = "You can't post a blank comment.  "
      redirect_to @thing
    end
  end


  private
  
  def comment_params
    params.require(:comment).permit(:thing_id, :description, :content)
  end

end
