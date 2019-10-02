class User < ApplicationRecord
    has_many :urls
    
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
                length: { minimum: 6 },
                if: -> { new_record? || !password.nil? }

    def self.all_without_password_and_timestamps
        users = []
        self.all.each do |user|
            users.push({
                name: user.name,
                email: user.email,
                username: user.username
            })
        end
        return users
    end

    def front_urls
        Url.urls_with_front_url(self.urls)
    end
end
