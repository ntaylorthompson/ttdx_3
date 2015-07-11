class Thing < ActiveRecord::Base

  belongs_to :user
  has_many :solutions
  accepts_nested_attributes_for :solutions
  
  validates :user_id, presence: true


  acts_as_taggable
end


#taylor added
