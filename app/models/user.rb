class User < ApplicationRecord
    
    validates :email, presence: true
    has_many :recipes
    has_secure_password

    def self.find_or_create_by_omniauth(auth_hash)
        self.where(:email => auth_hash["info"]["email"]).first_or_create do |user|
            user.password = SecureRandom.hex
        # oauth_email = auth_hash["info"]["email"]
        # if @user = User.find_by(:email => oauth_email)
        #     return @user
        # else
        #     user = User.create(:email => oauth_email, :password => SecureRandom.hex)

        end
    end
end
