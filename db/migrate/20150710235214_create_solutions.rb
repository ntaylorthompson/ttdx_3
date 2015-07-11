class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :kind
      t.text :description
      t.text :issues_description
      t.integer :user_id
      t.integer :thing_id

      t.timestamps null: false
    end
  end
end
