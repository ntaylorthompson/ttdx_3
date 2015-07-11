class Thing < ActiveRecord::Base

  belongs_to :user
  has_many :solutions
  
  validates :user_id, presence: true


  acts_as_taggable
end


#taylor added
