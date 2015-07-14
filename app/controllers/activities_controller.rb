class ActivitiesController < ApplicationController
  def index
    ft = current_user.followed_things
    followed_things = Thing.find(ft)
    ft_comment_ids = []
    for thing in followed_things
      for comment in thing.comments
        ft_comment_ids << comment.id
      end
    end
      
    
    #other people's (non-comment)activities on things you folow
    a = PublicActivity::Activity.where(trackable_type: "Thing", trackable_id: ft).where.not(owner_id: current_user.id) 

    #other peoples' comments on your things 
    b = PublicActivity::Activity.where(trackable_type: "Comment", trackable_id: ft_comment_ids).where.not(owner_id: current_user.id) 
    
    #other people's comments on your things 
    
    

#    @activities += PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id) 
#    comments_on_your_things = PublicActivity::Activity.order("created_at desc").where(trackable_type: "Comment").where(trackable_id: 3)
    
    

    
  #  another user comments on your thing 
    #someone changes a thing you follow
    #.comments
    #.updates
    #a friend does something 
    #.follows a thing
    #.creates a thing
    #.comments on a thing 
    
    @activities = (a +b).sort{|a,b| a.created_at <=> b.created_at }
    
  end
end
