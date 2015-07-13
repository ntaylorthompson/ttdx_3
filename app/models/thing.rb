class Thing < ActiveRecord::Base
  has_many :solutions
  has_many :comments
  accepts_nested_attributes_for :solutions

  belongs_to :user  
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc) }

  acts_as_taggable
end


#taylor added
