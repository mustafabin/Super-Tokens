class UsersController < ApplicationController
    before_action :authorize, only: [:profile]
    def create
        # create user from params 
        user = User.create!(email: params[:email], password: params[:password])
        # generate token with custom method
        token = SuperToken.generate_token(user, request)
        render json: user, serializer: UserTokenSerializer 
    end
    def profile 
        render json: @user
    end
    def login 
        user = User.find_by!(email:params[:email]).try(:authenticate, params[:password])
        if user
            # generate token with custom method
            token = SuperToken.generate_token(user, request)
            render json: user, serializer: UserTokenSerializer 
        else
            render json: {message: "Incorrect password"}
        end
    end
end
