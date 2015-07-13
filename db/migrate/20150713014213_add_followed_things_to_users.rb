class AddFollowedThingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followed_things, :text, array: true, default: []
  end
end
