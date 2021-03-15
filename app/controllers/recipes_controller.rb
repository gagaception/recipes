class RecipesController < ApplicationController
  def index
    response =  Recipes::RecipeListService.call
    if response.successful?
      @recipes = response.data
    else
      render file: "#{Rails.root}/public/500.html", status: 500
    end
  end

  def show
    response = Recipes::SingleRecipeService.call(params[:id])
    if response.successful?
      @recipe = response.data
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end
end
