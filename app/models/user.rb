class User < ApplicationRecord
    
    validates :email, presence: true
    has_many :recipes
    has_secure_password

    def self.create_with_omniauth(auth)
        create! do |user|
            user.provider = authp["provider"]
            user.user_id = auth["user_id"]
            user.name = auth["info"]["name"]
        end
    end
end
