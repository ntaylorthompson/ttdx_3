class Thing < ActiveRecord::Base
  has_many :solutions
  accepts_nested_attributes_for :solutions

  belongs_to :user  
  validates :user_id, presence: true


  acts_as_taggable
end


#taylor added
