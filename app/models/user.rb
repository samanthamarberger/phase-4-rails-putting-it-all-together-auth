class User < ApplicationRecord
    has_secure_password

    has_many :recipes

    validates :username, :password, :password_confirmation, presence: true, uniqueness: true
end
