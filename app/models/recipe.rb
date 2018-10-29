class Recipe < ApplicationRecord
    scope :ordered_by_name, -> { order(name: :asc) }
    belongs_to :user
    has_many :quantities
    has_many :ingredients, through: :quantities
    accepts_nested_attributes_for :quantities

    def quantities_attributes=(quant_att)
       self.quantities.destroy_all
        quant_att.each do |key, value|
             if value["ingredient_attributes"]["name"] != ""
                ingredient = Ingredient.find_or_create_by(name: value["ingredient_attributes"]["name"])
                self.quantities.build(amount: value["amount"], ingredient: ingredient)
            end
        end    
    end




   

end
