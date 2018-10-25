class Quantity < ApplicationRecord
    belongs_to :recipe
    belongs_to :ingredient
    accepts_nested_attributes_for :ingredient

    # def ingredient_attributes=(ing_att)
    #     ingredient = Ingredient.find_or_create_by(name: ing_att[:name])
    # end 

    

end
