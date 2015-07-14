class Thing < ActiveRecord::Base
  include PublicActivity::Model

  tracked owner: ->(controller, model) { controller.current_user }
  
  has_many :solutions
  has_many :comments
  accepts_nested_attributes_for :solutions

  belongs_to :user  
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc) }

  acts_as_taggable
end


#taylor added
