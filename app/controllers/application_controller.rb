class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def authorize
        is_banned = BannedIp.find_by(client_ip: request.remote_ip)
        if !is_banned 
            @user = SuperToken.vaildate_super(request.headers["SuperToken"], request)
        else
            @user = {status: "bad", error:"403 forbidden", message:"BANNED IP"}
        end
    end

    private
    def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found"}, status: :not_found
    end
    def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
