class CommentsController < ApplicationController

  def create
    thing_id = params[:comment][:thing_id]
    @thing = Thing.find(thing_id)
    @comment = @thing.comments.build(comment_params)
    @comment[:user_id] = @thing.user_id
    
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @thing
    else
      flash[:alert] = "Comment not created!"
      redirect_to @thing
    end
  end


  private
  
  def comment_params
    params.require(:comment).permit(:thing_id, :description, :content)
  end

end
