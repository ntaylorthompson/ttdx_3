class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :users, :followed_things, :array
  end
end
