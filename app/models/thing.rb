class Thing < ActiveRecord::Base
  include PublicActivity::Model
  validates :object_description, presence: true, length: { maximum: 200 }
  validates :tag_list, length: { maximum: 100 }
  validates :solution_description, length: { maximum: 2000 }
  validates :problem_description, length: { maximum: 2000 }    

  #REQUIRES USER_ID EXCEPT FOR INITIAL SIGNUP ACTION
#  tracked owner: ->(controller, model) { controller.current_user }, unless: :user_not_required?
#  validates :user_id, presence: true, unless: :user_not_required?  #REQUIRES USER_ID EXCEPT FOR INITIAL SIGNUP ACTION
    
  has_many :solutions
  has_many :comments
  accepts_nested_attributes_for :solutions

  belongs_to :user  


  attr_accessor :user_not_required

  
  default_scope -> { order(updated_at: :desc) }

  acts_as_taggable
  
  
  
  def self.search_and_order(search, page_number)
    if search
      where("object_description LIKE ?", "%#{search.downcase}%").order(updated_at: :asc).page page_number
    else
      order(updated_at: :asc).page page_number
    end
  end
  
  def user_not_required? 
    user_not_required == 'true' || user_not_required == true
  end

  
  
end


#taylor added
