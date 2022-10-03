class User < ApplicationRecord
    has_secure_password
    validates_presence_of :email
    validates_uniqueness_of :email
    has_many :super_tokens

    def profile
        {email:self.email,created_at:self.created_at,updated_at:self.updated_at}
    end
end
