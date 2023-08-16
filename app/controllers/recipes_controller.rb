class RecipesController < ApplicationController
    before_action :authorized

    def index
        recipes = current_user.recipes
        render json: recipes, status: :ok
    end

    def show
        recipe = current_user.recipes.find_by(id: params[:id])
        if recipe
            render json: recipe, status: :ok
        else
            render json: { errors: "not found" }, status: :unauthorized
        end
    end

    def create 
        recipe = current_user.recipes.create(recipe_params)
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: recipes.errors.full_messages}, status: :unprocessable_entity
    end

    private

    def current_user
        User.find_by(:id session[:user_id])
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end

end
