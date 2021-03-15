class RecipesController < ApplicationController
  def index
    response =  Recipes::RecipeListService.call(params[:page], params[:per_page], params[:order_field])
    if response.successful?
      @recipes = Recipes::RecipeTransformService.call(response.data).data
    else
      render file: "#{Rails.root}/public/500.html", status: 500
    end
  end

  def show
    response = Recipes::SingleRecipeService.call(params[:id])
    if response.successful?
      @recipe = Recipes::RecipeTransformService.call(response.data).data
    else
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end
end
