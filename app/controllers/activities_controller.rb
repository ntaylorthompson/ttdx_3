class ActivitiesController < ApplicationController
  helper_method :activity_type

  def index
    ft = current_user.followed_things
    
    #create an array of followed_thing_comment ids 
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

    #create an array of user_thing comments
    ut_comment_ids = []
    for thing in current_user.things
      for comment in thing.comments
        ut_comment_ids << comment.id
      end
    end
        
    #other (non-comment) changes to things you folow
    a = PublicActivity::Activity.where(trackable_type: "Thing", trackable_id: ft).where.not(owner_id: current_user.id) 
    

    #other peoples' comments on things you follow
    b = PublicActivity::Activity.where(trackable_type: "Comment", trackable_id: ft_comment_ids).where.not(owner_id: current_user.id) 
    
    #other people follow your things     
    c = PublicActivity::Activity.where(trackable_type: "User", relevant_obj_id: user_things).where.not(owner_id: current_user.id) 
#    PublicActivity::Activity.where(parameters: ft)

    #other people comment on your things
    d = PublicActivity::Activity.where(trackable_type: "Comment", trackable_id: ut_comment_ids).where.not(owner_id: current_user.id)     
    
    #a friend does something 
    #.follows a thing
    #.creates a thing
    #.comments on a thing 
    
    @activities = (a +b + c + d).sort{|a,b| a.created_at <=> b.created_at }.reverse
    


    def activity_type (activity)
      if activity.key == 'thing.update'
        "changed a thing you follow"
      elsif activity.key == 'user.thing_followed'
        "followed your thing"
      elsif Comment.find(activity.trackable_id).thing.user == current_user
        "commented on your thing"        
      else 
        "commented on a thing you follow"        
      end
    end
    
  end
end
