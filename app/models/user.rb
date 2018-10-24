class User < ApplicationRecord
    
    validates :email, presence: true
    has_many :recipes
    has_secure_password
end
