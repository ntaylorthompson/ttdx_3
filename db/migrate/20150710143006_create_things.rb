class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.references :user, index: true, foreign_key: true
      t.text :object_description
      t.text :problem_description
      t.text :solution_description

      t.timestamps null: false
    end
  end
end
