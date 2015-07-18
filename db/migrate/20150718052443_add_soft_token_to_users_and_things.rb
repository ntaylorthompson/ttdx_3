class AddSoftTokenToUsersAndThings < ActiveRecord::Migration
  def change
    add_column :users, :soft_token, :string
    add_column :things, :soft_token, :string
  end
end
