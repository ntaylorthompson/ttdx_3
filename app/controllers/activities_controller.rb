class ActivitiesController < ApplicationController
  def index
    ft = current_user.followed_things
    
    #create an array of followed_comment ids 
    followed_things = Thing.find(ft)
    ft_comment_ids = []
    for thing in followed_things
      for comment in thing.comments
        ft_comment_ids << comment.id
      end
    end
  
    #create an array of user things
    user_things = []
    for thing in current_user.things
      user_things << thing.id
    end 
    
    #other (non-comment) changes to things you folow
    a = PublicActivity::Activity.where(trackable_type: "Thing", trackable_id: ft).where.not(owner_id: current_user.id) 
    
    #other peoples' comments on your things 
    b = PublicActivity::Activity.where(trackable_type: "Comment", trackable_id: ft_comment_ids).where.not(owner_id: current_user.id) 
    
    #other people follow your things     
    c = PublicActivity::Activity.where(trackable_type: "User", relevant_obj_id: user_things).where.not(owner_id: current_user.id) 
#    PublicActivity::Activity.where(parameters: ft)

    #a friend does something 
    #.follows a thing
    #.creates a thing
    #.comments on a thing 
    
    @activities = (a +b + c).sort{|a,b| a.created_at <=> b.created_at }.reverse
    
  end
end
