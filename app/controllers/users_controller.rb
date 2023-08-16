class UsersController < ApplicationController

    #get current user
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :ok
        else
            render json: {error: "Not Authorized"}, status: :unauthorized
        end
    end

    #signup
    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity 
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, image_url, :bio)
    end

end
