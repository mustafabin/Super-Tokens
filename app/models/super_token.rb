class SuperToken < ApplicationRecord
    validates_uniqueness_of :token
    belongs_to :user
    # if no limit is desired then set const to 0
    LIMIT_TOKENS_PER_USER = 2 
    def self.generate_token(user,request)
        if user && request
            all_tokens = SuperToken.where(user_id: user.id)
            if all_tokens.length >= LIMIT_TOKENS_PER_USER
                all_tokens.order("updated_at")[0].destroy
            end
            # generate has https://github.com/rails/rails/blob/main/activerecord/lib/active_record/secure_token.rb
            hash = SecureRandom.base58(36)
            # generate token based off user
            SuperToken.create!(token:hash, user_id: user.id, client_ip: request.remote_ip, agent: request.user_agent)
        else 
            raise "user and/or request arguments undefined"
        end
    end
    def self.vaildate_super(token,request)
        super_token = SuperToken.find_by!(token:token)
        if super_token.client_ip == request.remote_ip
            if is_expired super_token.updated_at.to_i
                super_token.destroy 
                {status: "bad", error:"401 not authorized", message:"EXPIRED TOKEN"}
            else
                super_token.update(updated_at: Time.now)
                return  {status: "ok", user:super_token.user}
            end
        else
            {status: "bad", error:"403 forbidden", message:"IP DOESNT MATCH"}
        end
    end


    def self.expiry_time days
        86400 * days
    end

    def self.is_expired time
        age = Time.now.to_i - time
        expiry_time(14) < age ? true : false
    end

end
