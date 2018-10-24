class Recipe < ApplicationRecord
    belongs_to :user
    has_many :quantities
    has_many :ingredients, through: :quantities
end
