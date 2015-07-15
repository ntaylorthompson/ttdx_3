class AddLinkToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :link, :string
  end
end
