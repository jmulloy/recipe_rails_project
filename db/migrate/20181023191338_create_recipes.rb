class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :time
      t.text :instructions
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
