class CreateQuantities < ActiveRecord::Migration[5.2]
  def change
    create_table :quantities do |t|
      t.integer :recipe_id
      t.integer :ingredients_id
      t.integer :amount

      t.timestamps
    end
  end
end
