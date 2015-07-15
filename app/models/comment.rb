class Comment < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  validates :content, presence: true, length: { maximum: 2000 }
  
  belongs_to :user
  belongs_to :thing, touch: true  
  validates :user_id, presence: true
  validates :thing_id, presence: true  
  default_scope -> { order(updated_at: :desc) }
end
