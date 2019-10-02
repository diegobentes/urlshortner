class ApplicationController < ActionController::API
    
    
    def redirection
        url = Url.find_by_short_url(params[:short_url])
        if url && url.status then
            render json: url
        else
            render json: { error: 'not_found' }, status: 404
        end
    end
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
    
end
