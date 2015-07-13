class Solution < ActiveRecord::Base
  include PublicActivity::Model
#  tracked owner: ->(controller, model) { controller.current_user }

  belongs_to :thing
end
