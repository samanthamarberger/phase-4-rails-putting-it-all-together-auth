class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    before_action :require_login, only: [:show]

    def show
        user = User.find(session[:user_id])
        render json: user, status: :ok, except: [:encrypted_password]
    end

    def create
        user = User.create!(user_params)
        render json: user, status: :created
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, image_url, :bio)
    end

    def render_unprocessable_entity(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end

    def require_login
        unless session[:user_id]
            render json: { error: "Unauthorized" }, status: :unauthorized
        end
    end

end
