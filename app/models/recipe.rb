class Recipe < ApplicationRecord
    belongs_to :user
    has_many :quantities
    has_many :ingredients, through: :quantities
    accepts_nested_attributes_for :quantities

    def quantities_attributes=(quantity)
        binding.pry
    end

end
