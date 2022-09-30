class UsersController < ApplicationController
    def profile 
        render json: {message: "profile route :)"}
    end
    def login 
        render json: {message: "login route :)"}
    end
end
