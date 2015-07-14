class AddCustomFieldToActivities < ActiveRecord::Migration

  #added custom attribute to Activity to let me add notifs to tracked objects 
  def change
    change_table :activities do |t|
      t.integer :relevant_obj_id
    end
  end

end



