class User < ApplicationRecord
    validates :username, presence: true
    validates :email, presence: true
    has_many :recipes
    has_secure_password
end
