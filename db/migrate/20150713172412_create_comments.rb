class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :description
      t.references :user, index: true, foreign_key: true
      t.references :thing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
