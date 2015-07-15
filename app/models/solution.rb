class Solution < ActiveRecord::Base
  include PublicActivity::Model
#  tracked owner: ->(controller, model) { controller.current_user }
  belongs_to :thing, touch: true
  validates :issues_description, length: { maximum: 1000 }  
  validates :description, length: { maximum: 1000 }    
end
