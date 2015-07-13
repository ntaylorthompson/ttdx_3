class Comment < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }

  belongs_to :user
  belongs_to :thing  
  validates :user_id, presence: true
  validates :thing_id, presence: true  
  default_scope -> { order(updated_at: :desc) }
end
