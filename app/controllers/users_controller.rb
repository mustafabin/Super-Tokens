class UsersController < ApplicationController
    before_action :authorize, only: [:profile]
    def create
        # check if request ip is banned 
        is_banned = BannedIp.find_by(client_ip: request.remote_ip)
        if !is_banned 
            # create user from params 
            user = User.create!(email: params[:email], password: params[:password])
            # generate token with custom method
            token = SuperToken.generate_token(user, request)
            render json: user, serializer: UserTokenSerializer 
        else
            render json: {error: "Your Ip banned :("}
        end
    end
    def profile 
        render json: @user
    end
    def login 
        render json: {message: "login route :)"}
    end
end
