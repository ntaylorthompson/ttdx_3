class Admin::BaseController < ApplicationController
  before_filter :require_admin!

  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)

    @count_user = User.users_count
    @count_activated_user = User.includes(:things).where.not('things.id' => nil).count
    @pct_activated = 100.0 * (@count_activated_user.to_f - 1) / @count_user.to_f

    @count_thing = Thing.count
    @count_comment = Comment.count 
    @count_follows = PublicActivity::Activity.where(trackable_type: "Comment").count
    
  end
end
